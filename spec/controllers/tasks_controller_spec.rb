# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let!(:day) { create(:day) }
  let!(:task) { create(:task) }
  before { sign_in_user }
  describe 'POST #create' do
    context 'with valid attributes' do
      def create_task
        post :create, params: { day_id: day, task: attributes_for(:task), format: :json }
      end
      it 'saves a new task in the database' do
        expect { create_task }.to change(day.tasks, :count).by(1)
      end
      it 'test http status' do
        post :create, params: { day_id: day, task: attributes_for(:task), task_id: task, format: :json }
        expect(response).to have_http_status(200)
      end
    end
  end
  describe 'PATH #update' do
    context 'valid attributes' do
      it 'assign the requested task @task' do
        patch :update, params: { day_id: day, id: task, task: attributes_for(:task) }
        expect(assigns(:task)).to eq task
      end
    end
  end
  describe 'DELETE #destroy' do
    before { task }
    it 'delete task' do
      expect { delete :destroy, params: { day_id: day, id: task, format: :json } }
        .to change(Task, :count).by(-1)
    end
  end
end
