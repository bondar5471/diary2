# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Task, type: :model do
  it { should validate_presence_of :list }
  it { should validate_presence_of :date_end }
  it { should validate_presence_of :duration }
  it { should belong_to(:day) }
end
