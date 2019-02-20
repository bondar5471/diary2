class Api::V1::SessionsController < ActionController::API

  def create
    @user = User.find_by(email: params[:email])

    if @user&.valid_password?(params[:password])
      render json: @user.as_json(only: [:email, :id]), status: :created, status: :created
    else
      head(:unauthorized)
    end
  end

  def destroy
    current_user&.authentication_token = nil
    if current_user.save
      head(:ok)
    else
      head(:unauthorized)
    end
  end
end
