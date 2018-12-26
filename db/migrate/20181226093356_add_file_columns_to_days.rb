class AddFileColumnsToDays < ActiveRecord::Migration[5.2]
  def up
    add_attachment :days, :attach_file
  end
  def down
    remove_attachment :days, :attach_file
  end
end
