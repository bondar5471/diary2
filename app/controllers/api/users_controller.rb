module Api
  class UsersController < ApiController

    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user

    def create
      @user = User.create!(user_params)
      json_response(@user, :created)
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end