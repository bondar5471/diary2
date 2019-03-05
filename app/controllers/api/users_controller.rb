# frozen_string_literal: true

module Api
  class UsersController < ApiController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user
    before_action :find_user, only: [:destroy]
    def create
      @user = User.create!(user_params)
      json_response(@user, :created)
    end

    def destroy
      @user.destroy
      head :no_content, status: :ok
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end
end
