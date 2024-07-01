class MessagesController < ApplicationController
  before_action :set_chatroom

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
      sender_id: @message.user.id
    )
    head :ok
  end

  def destroy
    @message = @chatroom.messages.find(params[:id])
    if @message.user == current_user
      @message.destroy
      redirect_to @chatroom, notice: "Message was successfully deleted."
    else
      redirect_to @chatroom, notice: "Not permitted."
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
