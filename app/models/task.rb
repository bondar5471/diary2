# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :day, optional: true, touch: true
  belongs_to :user, optional: true
  has_many :subtasks_finish, -> { where(status: 'finished') }, class_name: 'Task', foreign_key: 'parent_id'
  has_many :subtasks, class_name: 'Task', foreign_key: 'parent_id'
  validates :description, presence: true, length: { maximum: 50 }
  validates :date_end, presence: true
  validates :duration, presence: true

  enum status: %i[in_progress finished]
  enum duration: %i[day week month year]

  scope :year, -> { where(duration: 3) }
  scope :month, -> { where(duration: 2) }
  scope :week, -> { where(duration: 1) }
  scope :day, -> { where(duration: 0) }

  def make_status!
    Task.week.each do |task|
      if task.subtasks.count == task.subtasks_finish.count
        task.update!(status: :finished)
      else
        task.update!(status: :in_progress)
      end
    end
  end
end
