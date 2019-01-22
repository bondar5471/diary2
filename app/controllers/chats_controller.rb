class ChatsController < ApplicationController
  include Clearance::Controller
  def index
    @messages = Message.order(created_at: :asc)
  end
end