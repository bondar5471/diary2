json.chats @chats do |chat|
  json.(chat, :id, :email, :message, :chatroom_id)
end