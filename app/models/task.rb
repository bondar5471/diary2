# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :day, required: false
  validates :list, presence: true
end
