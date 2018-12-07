# frozen_string_literal: true
class Task < ApplicationRecord
  belongs_to :day, required: false, touch: true
  validates :list, presence: true
  validates :datebeggin, presence: true
  validates :dateend, presence: true
end

