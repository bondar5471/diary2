# frozen_string_literal: true

class AddTypeToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :task_type, :integer, index: true
  end
end
