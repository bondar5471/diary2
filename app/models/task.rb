# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :day, required: false, touch: true
  belongs_to :user, optional: true
  has_many :subtasks, dependent: :destroy
  validates :list, presence: true, length: { maximum: 50 }
  validates :date_end, presence: true
  validates :duration, presence: true

  enum status: %i[in_progress finished]
  enum duration: %i[day week month year]

  scope :year, -> { where(duration: 3) }
  scope :month, -> { where(duration: 2) }
  scope :week, -> { where(duration: 1) }
  scope :day, -> { where(duration: 0) }

  def mark_task!(task_id)
    ActiveRecord::Base.transaction do
      task = Task.week.find(task_id)
      count = 0
      task.subtasks.each do |subtask|
        count += 1 if subtask.resolved == true
        if count >= 5
          task.update!(status: :finished)
        else
          task.update!(status: :in_progress)
        end
      end
    end
  end
end
