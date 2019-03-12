# frozen_string_literal: true

require 'rails_helper'

describe 'Subtask API' do
  let!(:task) { create(:task) }
  let(:jwt) { Knock::AuthToken.new(payload: { sub: task.user_id }).token }

  let(:subtask) { create(:subtask) }
  before do
    get  "/api/days/#{task.day_id}/tasks/#{task.id}/subtasks/",
         headers: { format: JSON, 'Authorization': 'bearer ' + jwt }
  end

  describe 'GET index' do
    context 'authorize' do
      it 'return 200 status code' do
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST create' do
    it 'response after create subtask' do
      subtask = { subtask_list:
                      [
                        { task_id: task.id,
                          description: task.list,
                          date: task.date_end },

                        { task_id: task.id,
                          description: task.list,
                          date: task.date_end - 1 },

                        { task_id: task.id,
                          description: task.list,
                          date: task.date_end - 2 },

                        { task_id: task.id,
                          description: task.list,
                          date: task.date_end - 3 },

                        { task_id: task.id,
                          description: task.list,
                          date: task.date_end - 4 },

                        { task_id: task.id,
                          description: task.list,
                          date: task.date_end - 5 },

                        { task_id: task.id,
                          description: task.list,
                          date: task.date_end - 6 }

                      ] }
      post "/api/days/#{task.day_id}/tasks/#{task.id}/subtasks",
           headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
           params: subtask
      expect(response).to have_http_status(200)
    end
  end

  # describe 'PATCH update' do
  #   it 'response after update subtask' do
  #      patch "/api/days/#{task.day_id}/tasks/#{task.id}/subtasks/#{subtask.id}",
  #        headers: { format: JSON, 'Authorization': 'bearer ' + jwt },
  #            params: {subtask: {resolved: true}}
  #      binding.pry
  #     expect(response).to have_http_status(204)
  #   end
  # end
end
