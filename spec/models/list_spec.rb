# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:cards) }
  it { should validate_length_of(:name).is_at_most(50) }
end
