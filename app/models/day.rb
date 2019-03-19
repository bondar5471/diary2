# frozen_string_literal: true

class Day < ApplicationRecord
  validates :date, presence: true
  validates :attach_file, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  has_many :tasks, dependent: :destroy
  scope :successful, -> { where(successful: true) }
  scope :unsuccessful, -> { where(successful: false) }
  scope :not_set, -> { where(successful: nil) }
  has_many :task_done, -> { where(status: 'finished') }, class_name: 'Task'
  belongs_to :user, optional: true
  has_one_attached :attach_file

  def self.complete_successful
    Day.all.each do |day|
      if day.tasks.count == 0
        day.update!(report: day.report, successful: nil)
      elsif  day.tasks.count == day.task_done.count
        day.update!(report: day.report, successful: true)
      else
        day.update!(report: day.report, successful: false)
      end
    end
  end
end
