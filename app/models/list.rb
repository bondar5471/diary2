# frozen_string_literal: true

class List < ApplicationRecord
  acts_as_list
  has_many :cards, -> { order(position: :asc) }, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  scope :sorted, -> { order(position: :asc) }
end
