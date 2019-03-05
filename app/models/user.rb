# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :days, dependent: :destroy
  has_many :lists, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :cards, dependent: :destroy
  validate :password_complexity

  alias authenticate valid_password?

  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[_#?!@$%^&*-]).{6,70}$/

    errors.add :password, '8-20 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    user
  end

  def to_token_payload
    {
      sub: id,
      email: email
    }
  end

  after_create :create_days

  def create_days
    today = Time.zone.today
    dates = (today.beginning_of_year..today.end_of_year).to_a
    sql_dates = dates.map { |d| "('#{d}', '#{User.last.id}', '#{Time.zone.now}', '#{Time.zone.now}')" }.join(', ')
    ActiveRecord::Base.connection.execute("INSERT INTO days (date, user_id, created_at, updated_at) VALUES #{sql_dates}")
  end

  def creator_of?(thing)
    id == thing.user_id
  end
end
