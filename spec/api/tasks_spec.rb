# frozen_string_literal: true

require 'rails_helper'

describe 'Task API' do
  let(:user) { create(:user) }
  let(:day) { create(:day) }
  let(:jwt) { Knock::AuthToken.new(payload: { sub: day.user_id }).token }
  let(:task) { create(:task) }

  before do
    get  "/api/days/#{day.id}/tasks",
         headers: { format: JSON, 'Authorization': 'bearer ' + jwt }
  end

  describe 'GET index' do
    context 'authorize' do
      it 'return 200 status code' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'GET show' do
    it 'return task' do
      get  "/api/days/#{day.id}/tasks/#{task.id}",
           headers: { format: JSON, 'Authorization': 'bearer ' + jwt }
      expect(response.body).to include('MyTask')
    end
  end

  describe 'POST create' do
    let(:user) { create(:user) }
    let(:jwt) { Knock::AuthToken.new(payload: { sub: day.user_id }).token }
    it 'response after create ' do
      post "/api/days/#{day.id}/tasks/", headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
                                         params: { task: { description: task.description,
                                                           date_end: task.date_end, duration: 'day' } }
      expect(response).to have_http_status(201)
    end
    it 'response after error ' do
      post "/api/days/#{day.id}/tasks/", headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
                                         params: { task: { description: task.description, duration: 'day' } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'PUT task on day' do
    let(:user) { create(:user) }
    let(:jwt) { Knock::AuthToken.new(payload: { sub: day.user_id }).token }
    it 'response after update day' do
      put "/api/days/#{day.id}/tasks/#{task.id}",
          headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
          params: { task: { description: 'dsfsdf', date_end: task.date_end, duration: 'day' } }
      expect(response).to have_http_status(200)
    end
    it 'response after error update ' do
      put "/api/days/#{day.id}/tasks/#{task.id}",
          headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
          params: { task: { description: '' } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'POST multi_create task' do
    let(:user) { create(:user) }
    let(:jwt) { Knock::AuthToken.new(payload: { sub: day.user_id }).token }
    it 'response after multi_create' do
      post '/api/tasks/multi_create', headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
                                      params: { days: %w[4 2 5], task_id: task.id, task: { description: task.description } }
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE task' do
    let(:user) { create(:user) }
    let(:jwt) { Knock::AuthToken.new(payload: { sub: day.user_id }).token }
    it 'response delete' do
      delete "/api/days/#{day.id}/tasks/#{task.id}",
             headers: { format: JSON, 'Authorization': 'bearer ' + jwt }
      expect(response).to have_http_status(204)
    end
    it 'response error delete' do
      delete "/api/days/#{day.id}/tasks/#{task.id}"
      expect(response).to have_http_status(401)
    end
  end
end
