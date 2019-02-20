module Api
  class ApiController < ApplicationController
    before_action :authenticate_user
    protect_from_forgery with: :null_session
    respond_to :json

    include Knock::Authenticable
    include Api::Concerns::Response
    include Api::Concerns::ExceptionHandler

    undef_method :current_user
  end
end