class AddUserToDay < ActiveRecord::Migration[5.2]
  def change
    add_column :days, :user_id, :integer, index: true
  end
end
