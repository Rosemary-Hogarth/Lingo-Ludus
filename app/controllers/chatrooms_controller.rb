class ChatroomsController < ApplicationController
  def show
    @chatrooms = Chatroom.all
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    @user = current_user
    @new_chatroom = Chatroom.new
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    if @chatroom.save
      redirect_to @chatroom, notice: "Chatroom was successfully created."
    else
      render :new
    end
  end

  # def destroy
  #   @chatroom = Chatroom.find(params[:id])
  #   @chatroom.destroy
  #   redirect_to chatroom_path(@chatroom.first), notice: 'Chatroom was successfully deleted.'
  # end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end
end
