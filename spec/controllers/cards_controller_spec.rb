# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let!(:list) { create(:list) }
  let(:card) { create(:card) }

  describe 'GET #index' do
    let(:card) { create_list(:card, 2) }

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
    context 'with invalid attributes' do
      it 'saves a new card in the database' do
        expect do
          post :create, params: { card: attributes_for(:card), list_id: list, format: :json }
        end.to change(list.cards, :count).by(1)
      end
      it 'status test after create' do
        post :create, params: { card: attributes_for(:card), list_id: list, format: :json }
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
