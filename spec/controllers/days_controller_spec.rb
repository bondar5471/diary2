# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DaysController, type: :controller do
  let(:day) { create(:day) }

  describe 'GET #index' do
    let(:days) { create_list(:day, 2) }

    before { get :index }

    it 'render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: day } }

    it 'assings the  requested to @day' do
      expect(assigns(:day)).to eq day
    end

    it 'render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }
    it 'assign a new Day to @day' do
      expect(assigns(:day)).to be_a_new(Day)
    end

    it 'render new view' do
      expect(response).to render_template :new
    end
  end
  describe 'GET #edit' do
    before { get :edit, params: { id: day } }

    it 'assigns the  requested to @day' do
      expect(assigns(:day)).to eq day
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'save the new day the database' do
        expect { post :create, params: { day: attributes_for(:day) } }.to change(Day, :count).by(1)
      end
      it 'redirects to show view' do
        post :create, params: { day: attributes_for(:day) }
        expect(response).to redirect_to days_path
      end
    end
  end
  describe 'PATH #update' do
    context 'valid attributes' do
      it 'assign the requested day @day' do
        patch :update, params: { id: day, day: attributes_for(:day) }
        expect(assigns(:day)).to eq day
      end
    end
  end
  describe 'DELETE #destroy' do
    before { day }
    it 'delete day' do
      expect { delete :destroy, params: { id: day } }.to change(Day, :count).by(-1)
    end
  end
end
