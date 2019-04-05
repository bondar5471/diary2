# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :day, optional: true, touch: true
  belongs_to :user, optional: true
  has_many :subtasks_finish, -> { where(status: 'finished') }, class_name: 'Task', foreign_key: 'parent_id'
  has_many :subtasks, class_name: 'Task', foreign_key: 'parent_id'
  validates :description, presence: true, length: { maximum: 50 }
  validates :date_end, presence: true
  validates :duration, presence: true
  belongs_to :parent_task, class_name: 'Task', foreign_key: 'parent_id', optional: true

  #after_destroy :destroy_day, if: ->(object) { object.day.tasks.empty? }
  after_update :complete_day, if: ->(object) { object.day.task_done.count == object.day.tasks.count }
  after_update :uncomplete_day, if: ->(object) { object.day.task_done.count != object.day.tasks.count }

  enum status: %i[in_progress finished]
  enum duration: %i[day week month year]

  scope :year, -> { where(duration: 3) }
  scope :month, -> { where(duration: 2) }
  scope :week, -> { where(duration: 1) }
  scope :day, -> { where(duration: 0) }

  def make_status!
    if parent_id
      if parent_task.subtasks.count == parent_task.subtasks_finish.count
        parent_task.update!(status: :finished)
      else
        parent_task.update!(status: :in_progress)
      end
    end
  end

  private

  # def destroy_day
  #   day.destroy
  # end

  def complete_day
    day.update(report: day.report, successful: true)
  end

  def uncomplete_day
    day.update(report: day.report, successful: false)
  end
end
