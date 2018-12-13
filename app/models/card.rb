# frozen_string_literal: true

class Card < ApplicationRecord
  acts_as_list scope: :list
  belongs_to :list
  validates :name, presence: true
  belongs_to :user
end
