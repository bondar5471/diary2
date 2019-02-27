# frozen_string_literal: true

class Card < ApplicationRecord
  acts_as_list scope: :list
  belongs_to :list, optional: true
  validates :title, presence: true
  belongs_to :user, optional: true
end
