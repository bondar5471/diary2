require 'rails_helper'

RSpec.describe 'POST /api/v1/user_token', type: :request do
  let(:user) { create(:user) }
  let(:jwt) { Knock::AuthToken.new(payload: { sub: user.id }).token }
  let(:url) { '/user_token' }

  let(:params) do
    {
        auth: {
            email: user.email,
            password: user.password,
        }
    }
  end

  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'returns 201' do
      expect(response).to have_http_status(201)
    end
    it 'returns JTW token in authorization header' do
      response.headers['Authorization'] = "Bearer #{jwt}"
    end
  end

  context 'when login params are incorrect' do
    let(:params_undef) do
      {
        auth: {
            email: 'dfssdfsdf@gmail.com',
            password: 'B5o4n7d1!',
        }
      }
    end
    before do
      post url, params: params_undef
    end
    it 'returns unathorized status' do
      expect(response.status) == 404
    end
  end
end
