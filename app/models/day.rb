# frozen_string_literal: true

class Day < ApplicationRecord
  validates :date, presence: true
  validates :report, presence: true, on: :update
  has_many :tasks, dependent: :destroy
  validates_length_of :report, maximum: 400, on: :update
end
