# frozen_string_literal: true

class FixColumnTypeTask < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :task_type, :duration
    rename_column :tasks, :completed, :status
  end
end
