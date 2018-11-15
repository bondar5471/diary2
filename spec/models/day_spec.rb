# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Day, type: :model do
  it { should validate_presence_of :date }
  it { should validate_presence_of :report }
  it { should have_many :tasks }
end
