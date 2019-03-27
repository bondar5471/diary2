# frozen_string_literal: true

require 'rails_helper'

describe 'POST /api/users', type: :request do
  let(:url) { '/api/users' }
  let(:params) do
    {
      user: {
        email: 'test@test.test',
        password: 'B5o4n7d1!',
        password_confirmation: 'B5o4n7d1!'
      }
    }
  end
  context 'when params are correct' do
    before do
      post url, params: params
    end

    it 'User create' do
      expect(response).to have_http_status(201)
    end
  end

  context 'when params are incorrect' do
    let(:params) do
      {
        user: {
          email: 'test@test.test',
          password: '1111111',
          password_confirmation: '1111111'
        }
      }
      before do
        post url, params: params
      end
      it 'User create' do
        expect(response).to have_http_status(422)
      end
    end
  end
end

describe 'DELETE /api/users', type: :request do
  context 'when params are correct' do
    let(:user) { create(:user) }
    let(:url) { "/api/users/#{user.id}" }

    before do
      delete url
    end

    it 'User destroy' do
      expect(response).to have_http_status(204)
    end
  end
end