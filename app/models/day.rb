# frozen_string_literal: true

class Day < ApplicationRecord
  validates :date, presence: true
  validates :report, presence: true, length: { maximum: 400 },on: :update
  has_many :tasks, dependent: :destroy

  # attr_accessor :skip_report_validation
  # scope :successday, -> { where(successful: true) }
  # scope :notsuccessday, -> { where(successful: false) }
end
