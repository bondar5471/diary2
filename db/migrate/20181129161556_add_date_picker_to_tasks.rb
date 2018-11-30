class AddDatePickerToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :datebeggin, :date, index: true
    add_column :tasks, :dateend, :date, index: true
  end
end
