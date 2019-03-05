# frozen_string_literal: true

class AddTaskImportance < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :importance, :boolean, default: false, index: true
  end
end
