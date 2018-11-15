# frozen_string_literal: true

class Notice < ApplicationRecord
  validates :text, :title, presence: true
end
