class MessagesController < ApplicationController
  before_action :set_chatroom, only: [:create]

  def create
    # content, chatroom, user
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user

    @message.save
    ChatroomChannel.broadcast_to(
      @chatroom,
      message: render_to_string(
        partial: "messages/message",
        locals: { message: @message }
      ),
      sender_id: @message.user.id,
      message_id: @message.id
    )
    head :ok
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.user == current_user
      @message.destroy
      ChatroomChannel.broadcast_to(
        @message.chatroom,
        deletedMessageId: @message.id
      )
      redirect_to @message.chatroom, notice: "Message was successfully deleted."
    else
      redirect_to @message.chatroom, notice: "Not permitted."
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def set_chatroom
    @chatroom = Chatroom.find(params[:chatroom_id])
  end
end
