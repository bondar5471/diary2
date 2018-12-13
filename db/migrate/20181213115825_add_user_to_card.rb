class AddUserToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :user_id, :integer, index: true
  end
end
