# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CardsController, type: :controller do
  let(:list) { create(:list) }
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
    it 'test http status' do
      post :create, params: { list_id: list, card: attributes_for(:card), format: :json }
      expect(response).to have_http_status(422)
    end
  end
  # describe 'POST #create' do
  #   context 'with valid attributes' do
  #     it 'saves a new card in the database' do
  #       expect { post :create, params: { list_id: list, card: attributes_for(:card), format: :json } }.to change(list.cards, :count).by(1)
  #     end
  #     it 'test http status' do
  #       post :create, params: { list_id: list, card: attributes_for(:card), card_id: card, format: :html }
  #       expect(response).to redirect_to card_path
  #     end
  #   end
  # end
end
