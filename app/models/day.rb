# frozen_string_literal: true
class Day < ApplicationRecord
  validates :date, presence: true
  validates :report, presence: true, length: { maximum: 400 }, on: :update
  has_many :tasks, dependent: :destroy
  has_attached_file :attach_file,
                    :styles => { :medium => "600x600>",
                    :thumb  => "300x300>" }
  validates_attachment_content_type :attach_file, :content_type => /\Aimage\/.*\Z/
  scope :successful, -> { where(successful: true) }
  scope :unsuccessful, -> { where(successful: false) }
  scope :not_set, -> { where(successful: nil) }
  belongs_to :user
end
