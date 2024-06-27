class ChatroomChannel < ApplicationCable::Channel
  # radio tower - transmits to users
  def subscribed
    # find the chatroom
    chatroom = Chatroom.find(params[:id])

    stream_for chatroom
  end


  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
