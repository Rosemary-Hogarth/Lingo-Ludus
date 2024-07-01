class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show, :edit, :update]

  def show
    @chatrooms = Chatroom.all.order(:id)
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

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @chatroom.update(chatroom_params)
      respond_to do |format|
        format.html { redirect_to chatroom_path(@chatroom), notice: 'Chatroom name updated successfully.' }
        format.js
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def chatroom_params
    params.require(:chatroom).permit(:name)
  end

  def set_chatroom
    @chatroom = Chatroom.find(params[:id])
  end
end
