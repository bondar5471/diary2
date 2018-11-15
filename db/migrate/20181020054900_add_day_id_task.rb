# frozen_string_literal: true

class AddDayIdTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :day_id, :integer, index: true
  end
end
