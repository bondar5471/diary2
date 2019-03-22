# frozen_string_literal: true

class Day < ApplicationRecord
  validates :date, presence: true

  has_many :tasks, dependent: :destroy
  scope :successful, -> { where(successful: true) }
  scope :unsuccessful, -> { where(successful: false) }
  scope :not_set, -> { where(successful: nil) }
  has_many :task_done, -> { where(status: 'finished') }, class_name: 'Task'
  belongs_to :user, optional: true

  def self.complete_successful
    ActiveRecord::Base.transaction do
      Day.all.find_each do |day|
        if day.tasks.count == 0
          day.update!(report: day.report, successful: nil)
        elsif day.tasks.count == day.task_done.count
          day.update!(report: day.report, successful: true)
        else
          day.update!(report: day.report, successful: false)
        end
      end
    end
  end
end
