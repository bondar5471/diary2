class List < ApplicationRecord
  acts_as_list
  belongs_to :day
  has_many :cards, ->{order(position: :asc)}, dependent: :destroy
  validates :name, presence: true, length: {maximum: 50}

  scope :sorted, -> { order(position: :asc)}
  # Ex:- scope :active, -> {where(:active => true)}
end
