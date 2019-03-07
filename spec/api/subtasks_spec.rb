# frozen_string_literal: true

require 'rails_helper'

describe 'Day API' do
  let(:user) { create(:user) }
  let(:jwt) { Knock::AuthToken.new(payload: { sub: user.id }).token }
  let(:day) { create(:day) }
  let(:task) { create(:task) }
  let(:subtask) { create(:subtask) }

  before { get  "/api/days/#{day.id}/tasks/#{task.id}/subtasks", headers: { format: JSON, 'Authorization': 'bearer ' + jwt } }

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
    it 'response after create task' do
      post "/api/days/#{day.id}/tasks/#{task.id}/subtasks", headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
                                                            params: { subtask: { description: task.list, date: task.date_end, resolved: false } }
      expect(response).to have_http_status(201)
    end
  end
end
