# frozen_string_literal: true

class List < ApplicationRecord
  acts_as_list
  has_many :cards, -> { order(position: :asc) }, dependent: :destroy, inverse_of: :list
  validates :name, presence: true, length: { maximum: 50 }
  scope :sorted, -> { order(position: :asc) }
  belongs_to :user
end
