# frozen_string_literal: true

module CompleteDaysSuccessful
  class << self
    def complete_successful(days)
      days.all.each do |day|
        if day.tasks.count.zero?
          day.destroy!
        elsif day.tasks.count == day.task_done.count
          day.update!(report: day.report, successful: true)
        else
          day.update!(report: day.report, successful: false)
        end
      end
    end
  end
end