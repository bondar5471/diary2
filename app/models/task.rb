# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :day, required: false, touch: true
  belongs_to :user, optional: true
  validates :list, presence: true
  validates :date_end, presence: true
  validates :duration, presence: true

  enum status: %i[in_progress finished]
  enum duration: %i[day week month year]

  scope :year, -> { where(duration: 3) }
  scope :month, -> { where(duration: 2) }
  scope :week, -> { where(duration: 1) }
  scope :day, -> { where(duration: 0) }
end
