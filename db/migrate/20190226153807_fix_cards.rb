class FixCards < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :description, :string, index: true
    rename_column :cards, :name, :title
  end
end
