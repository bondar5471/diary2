# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Day, type: :model do
  it { should validate_presence_of :date }
  it { should validate_length_of(:report).is_at_most(400).on(:update) }
  it { should have_many :tasks }
end
