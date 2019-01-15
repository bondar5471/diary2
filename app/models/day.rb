# frozen_string_literal: true

class Day < ApplicationRecord
  validates :date, presence: true
  validates :report, presence: true, length: { maximum: 400 }, on: :update
  validates :attach_file, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }

  has_many :tasks, dependent: :destroy
  scope :successful, -> { where(successful: true) }
  scope :unsuccessful, -> { where(successful: false) }
  scope :not_set, -> { where(successful: nil) }
  belongs_to :user, optional: true
  has_one_attached :attach_file
end
