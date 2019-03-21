# frozen_string_literal: true

require 'rails_helper'

describe 'Day API' do
  let(:user) { create(:user) }
  let(:jwt) { Knock::AuthToken.new(payload: { sub: user.id }).token }

  before { get '/api/days', headers: { format: JSON, 'Authorization': 'bearer ' + jwt } }

  let(:day) { days.first }

  describe 'GET index' do
    context 'authorize' do
      it 'return 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'return array days' do
        expect(response.body).to_not be_empty
      end
    end
  end
  describe 'PUT day' do
    let(:user) { create(:user) }
    let(:jwt) { Knock::AuthToken.new(payload: { sub: user.id }).token }
    let (:day) { create(:day) }
    it 'respomse after uddate day' do
      put "/api/days/#{day.id}", headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
                                 params: { day: { report: 'dsfsdf', successful: true } }
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET day autocomplete successful' do
    let(:user) { create(:user) }
    let(:jwt) { Knock::AuthToken.new(payload: { sub: user.id }).token }
    let (:day) { create(:day) }
    it 'response after autocomplete' do
      get '/api/days', headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
          params: {status: 'auto'}
      expect(response).to have_http_status(200)
    end
  end
end
