class ChatsController < ApplicationController
  def index
    @chatrooms = Chatroom.all
  end
  def create
    @chat = Chat.new(chat_params)
    respond_to do |format|
      if @chat.save
        format.json { render :show, status: :created, location: @chat }
      else
        format.json { render json: @chat.errors, status: :unprocessable_entity }
      end
    end
  end
  def new
    @chat = Chat.new
  end
  def show
    @chats = Chat.where(chatroom_id: params[:id])
    respond_to do |format|
      if @chats
        format.json { render :chats, status: :ok }
      else
        format.json { render json: @chats.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    def chat_params
      params.require(:chat).permit(:message, :email, :chatroom_id)
    end
end