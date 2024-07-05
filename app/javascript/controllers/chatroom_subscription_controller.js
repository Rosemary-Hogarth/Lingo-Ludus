import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static values = { chatroomId: Number, currentUserId: Number }
  static targets = ["messages", "message"]

  connect() {
    // subscribe to channel
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id :this.chatroomIdValue },
      { received: (data) => { this.#receive(data) } }
    )
    console.log(`Subscribed to the chatroom with the id ${this.chatroomIdValue}.`)


  }

  #receive(data) {
    if (data.sender_id) {
      this.#insertMessage(data)
    } else if (data.deletedMessageId) {
      this.#deleteMessage(data)
    }
  }

  #deleteMessage(data) {
    const messageId = `#message-${data.deletedMessageId}`
    const message = this.messagesTarget.querySelector(messageId).parentElement
    message.remove()
  }

  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"

  }

  #buildMessageElement(currentUserIsSender, message, messageId) {
    console.log(messageId)
    return `
      <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
        <div class="${this.#userStyleClass(currentUserIsSender)}">
          ${this.#buildDeleteLink(currentUserIsSender, messageId)}
          ${message}

      </div>
    </div>
  `
  }

  #buildDeleteLink(currentUserIsSender, messageId) {
    if (currentUserIsSender) {
      return `<a data-turbo-method="delete" data-turbo-confirm="Are you sure?" class="message-remove-link" href="messages/${messageId}">+</a>`
    }
  }

  // add message
  #insertMessage(data) {
    console.log("Received data: ", data);

    const currentUserIsSender = this.currentUserIdValue === data.sender_id;
    console.log(currentUserIsSender)
    console.log(this.currentUserIdValue)
    if (!data) {
      console.error("Received data is undefined or empty.");
      return;
    }

    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message, data.messageId);
      console.log("messageElement:", messageElement);
    // Inserting the messageElement in the DOM
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement);
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight);
  }


   // clears input field after message is sent
  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log("disconnecting from the channel...")
    this.channel.unsubscribe()
  }
}
