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

      it 'return array task' do
        expect(response.body).to_not be_empty
      end
    end
  end

  describe 'POST create' do
    let(:user) { create(:user) }
    let(:jwt) { Knock::AuthToken.new(payload: { sub: day.user_id }).token }
    it 'response after create task' do
      post "/api/days/#{day.id}/tasks/", headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
                                         params: { task: { description: task.description,
                                                           date_end: task.date_end, duration: 'day' } }
      expect(response).to have_http_status(201)
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
  end
end
