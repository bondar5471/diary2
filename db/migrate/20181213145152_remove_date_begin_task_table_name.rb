# frozen_string_literal: true

class RemoveDateBeginTaskTableName < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :date_begin
  end
end
