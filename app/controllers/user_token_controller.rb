class UserTokenController < Knock::AuthTokenController
  respond_to :json
  skip_before_action :verify_authenticity_token, raise: false
end
