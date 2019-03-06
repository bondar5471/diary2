require 'rails_helper'

RSpec.describe Subtask, type: :model do
  it { should belong_to(:task) }
end
