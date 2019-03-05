class CreateSubtasks < ActiveRecord::Migration[5.2]
  def change
    create_table :subtasks do |t|
      t.integer :task_id
      t.text :description
      t.date :date
      t.timestamps
      t.integer :user_id, index: true
    end
  end
end
