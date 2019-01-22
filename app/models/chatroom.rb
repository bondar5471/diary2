class Chatroom < ApplicationRecord
  after_create :notify_pusher
  has_many :chats

  def notify_pusher
    Pusher.trigger('chat', 'new-chatroom', self.as_json)
  end
end
