# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  let(:list) { create(:list) }
  before { sign_in_user }
  describe 'GET #new' do
    before { get :new }
    it 'assign a new List to @list' do
      expect(assigns(:list)).to be_a_new(List)
    end
    it 'status should be created' do
      post :create, params: { list: attributes_for(:list), list_id: list, format: :json }
      expect(response).to have_http_status(:created)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'save the new list the database' do
        expect { post :create, params: {  list: attributes_for(:list), format: :json } }.to change { List.count }.by(1)
      end
    end
  end

  describe 'PATCH #update' do
    context 'valid attributes' do
      it 'assign the requested list @list' do
        patch :update, params: { id: list, list: attributes_for(:list) }
        expect(assigns(:list)).to eq list
      end
    end
  end

  describe 'DELETE #destroy' do
    before { list }
    it 'delete day' do
      expect { delete :destroy, params: { id: list.id } }.to change(List, :count).by(-1)
    end
  end
  describe 'PATCH #move' do
    it 'Change position card' do
      patch :update, params: { id: list, list: attributes_for(:list) }
      expect(assigns(:list)).to eq list
    end
    it 'render template' do
      patch :update, params: { id: list, list: attributes_for(:list) }
      expect(response).to have_http_status(302)
    end
  end
end
