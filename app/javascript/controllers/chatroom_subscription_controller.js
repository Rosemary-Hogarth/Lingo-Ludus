import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chatroom-subscription"
export default class extends Controller {
  static values = { chatroomId: Number }
  static targets = ["messages", "header"]

  connect() {
    // subscribe to channel
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id:this.chatroomIdValue },
      { received: (data) => { this.#insertMessage(data) } }
    )
    this.addColor()
  }
  disconnect() {
    console.log("disconnecting from th channel...")
    this.channel.unsubscribe()
  }
  // clears input field after message is sent
  resetForm(event) {
    event.target.reset()
  }

  // add message
  #insertMessage(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    // scroll to bottom of list
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  addColor() {
    const header = this.headerTarget
    console.log("Header target:", this.headerTarget);
    switch (this.chatroomIdValue) {
      case 1:
        header.classList.add('color-1')
        break;
      case 2:
        header.classList.add('color-2')
        break;
      case 3:
        header.classList.add('color-3')
        break;
    }
  }
}
