# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:day) { create(:day) }
  let!(:task) { create(:task) }
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves a new task in the database' do
        expect do
          post :create, params: { task: attributes_for(:task), day_id: day, format: :json }
        end.to change(day.tasks, :count).by(1)
      end

      it 'render create template' do
        post :create, params: { task: attributes_for(:task), task_id: task, format: :json }
        expect(response).to render_template :create
      end
    end
  end
end
