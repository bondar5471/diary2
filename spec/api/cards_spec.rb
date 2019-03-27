# frozen_string_literal: true

require 'rails_helper'

describe 'Card API' do
  let(:user) { create(:user) }
  let(:jwt) { Knock::AuthToken.new(payload: { sub: user.id }).token }
  let(:card) { create(:card) }
  let(:list) { create(:list) }

  before { get  '/api/cards', headers: { format: JSON, 'Authorization': 'bearer ' + jwt } }

  describe 'GET index' do
    context 'authorize' do
      it 'return 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'return card' do
        expect(response.body).to_not be_empty
      end
    end
  end

  describe 'GET show' do
    let(:card) { create(:card) }
    it 'return 200 show' do
      get "/api/cards/#{card.id}", headers: { format: JSON, 'Authorization': 'bearer ' + jwt }
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET new' do
    it 'return new' do
      get '/api/cards/new', headers: { format: JSON, 'Authorization': 'bearer ' + jwt }
      expect(response).to have_http_status(204)
    end
  end

  describe 'POST create' do
    it 'response after create card' do
      post '/api/cards/', headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
                          params: { card: { title: 'dsfsdf', list_id: list.id } }
      expect(response).to have_http_status(201)
    end
    it 'response after create error' do
      post '/api/cards/', headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
                          params: { card: { title: '', list_id: list.id } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE destroy' do
    it 'response after delete card' do
      delete "/api/cards/#{card.id}", headers: { format: JSON, 'Authorization': 'bearer ' + jwt }
      expect(response).to have_http_status(204)
    end
  end
end
