class AddSubTaskResolResolved < ActiveRecord::Migration[5.2]
  def change
    add_column :subtasks, :resolved, :boolean, default: false, index: true
  end
end
