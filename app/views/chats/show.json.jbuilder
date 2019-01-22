json.extract! @chat, :id, :message, :email, :chatroom_id
    json.url chat_url(@chat, format: :json)
