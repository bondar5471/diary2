class AddCompletedToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :completed, :integer, default: 0, index: true
  end
end
