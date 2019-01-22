json.extract! @chatroom, :id, :email
json.url chatroom_url(@chatroom, format: :json)