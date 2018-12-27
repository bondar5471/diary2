# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :days, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :cards, dependent: :destroy
  # after_create :create_days

  # def create_days
  #   dates = Time.zone.today.beginning_of_year - 1.day
  #   Time.zone.today.end_of_year.yday.times do
  #   Day.create!(
  #     date: dates += 1.day,
  #     successful: nil,
  #     report: nil,
  #     user_id: id
  #   )
  #   end
  # end
  def creator_of?(thing)
    id == thing.user_id
  end
end
