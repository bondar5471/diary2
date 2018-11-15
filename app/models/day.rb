# frozen_string_literal: true

class Day < ApplicationRecord
  validates :date, presence: true
  validates :report, presence: true, length: { maximum: 400 }
  has_many :tasks, dependent: :destroy

  # scope :successday, -> { where(successful: true) }
  # scope :notsuccessday, -> { where(successful: false) }
end
