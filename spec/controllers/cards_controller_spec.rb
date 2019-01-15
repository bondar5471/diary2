# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:list) { create(:list) }
  let(:card) { create(:card) }
  before { sign_in_user }

  describe 'GET #index' do
    let(:card) { create_list(:cards, 2) }

    before { get :index }

    it 'render index view' do
      expect(response).to render_template :index
    end
  end
  describe 'GET #new' do
    before { get :new }
    it 'assign a new card to @card' do
      expect(assigns(:card)).to be_a_new(Card)
    end
  end
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new card in the database responce status' do
        expect do
          post :create, params: { card: attributes_for(:card), list_id: card, format: :json }
        end.to change(Card, :count).by(2)

        expect(response).to have_http_status(201)
      end
    end
  end
  describe 'PATCH #move' do
    it 'Change position card after drag and drop' do
      patch :update, params: { id: card, card: attributes_for(:card) }
      expect(assigns(:card)).to eq card
    end
    it 'render template' do
      patch :update, params: { id: card, card: attributes_for(:card) }
      expect(response).to have_http_status(302)
    end
  end
end
