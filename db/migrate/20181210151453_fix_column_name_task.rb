class FixColumnNameTask < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :datebeggin, :date_begin
    rename_column :tasks, :dateend, :date_end
  end
end
