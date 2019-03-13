# frozen_string_literal: true

class FixColumnNameTaskList < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :list, :description
  end
end
