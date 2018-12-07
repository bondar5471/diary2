# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:day) { create(:day) }
  let(:task) { create(:task) }
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new task in the database' do
        expect { post :create, params: { day_id: day, task: attributes_for(:task), format: :json } }.to change(day.tasks, :count).by(1)
      end
      it 'render create template' do
        post :create, params: { task: attributes_for(:task), task_id: task, format: :json }
        expect(response).to render_template :create
      end
    end
  end
  describe 'PATH #update' do
  end
  describe 'DELETE #destroy' do
    before { task }
    it 'delete day' do
      expect { delete :destroy, params: { day_id: day, id: task, format: :json } }
        .to change(Task, :count).by(-1)
    end
  end
end
