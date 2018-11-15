# frozen_string_literal: true

class CreateDays < ActiveRecord::Migration[5.2]
  def change
    create_table :days do |t|
      t.date :date
      t.boolean :successful
      t.text :report

      t.timestamps
    end
  end
end
