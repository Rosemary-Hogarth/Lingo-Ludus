class ChatroomsController < ApplicationController
  def show
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @user = current_user
  end
end
