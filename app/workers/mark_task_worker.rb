# frozen_string_literal: true

# class MarkTaskWorker
#
#   include Sidekiq::Worker
#
#   def perform(task_id)
#    task = Task.week.find(task_id)
#    count = 0
#    task.subtasks.each do |subtask|
#      if subtask.resolved == true
#        count = count +1
#      end
#      if count >= 5
#        task.update(status: :finished)
#        task.save!
#      else
#        task.update(status: :in_progress)
#        task.save!
#      end
#    end
#   end
#   def cancelled?
#     Sidekiq.redis {|c| c.exists("cancelled-#{jid}") }
#   end
#
#   def self.cancel!(jid)
#     Sidekiq.redis {|c| c.setex("cancelled-#{jid}", 86400, 1) }
#   end
# end
