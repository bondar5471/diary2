# frozen_string_literal: true

class Subtask < ApplicationRecord
  belongs_to :user
  belongs_to :task
end
