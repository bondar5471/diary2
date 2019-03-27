# frozen_string_literal: true

class Day < ApplicationRecord
  validates :date, presence: true

  has_many :tasks, dependent: :destroy
  scope :successful, -> { where(successful: true) }
  scope :unsuccessful, -> { where(successful: false) }
  scope :not_set, -> { where(successful: nil) }
  has_many :task_done, -> { where(status: 'finished') }, class_name: 'Task'
  belongs_to :user, optional: true
end
