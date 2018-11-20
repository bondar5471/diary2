class Card < ApplicationRecord
  acts_as_lists scope: :list
  belongs_to :list
  validates :name, presence: true
end
