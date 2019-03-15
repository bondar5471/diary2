# frozen_string_literal: true

class AddPatenTaskId < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :parent_id, :integer, index: true
  end
end
