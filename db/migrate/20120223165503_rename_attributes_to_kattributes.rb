class RenameAttributesToKattributes < ActiveRecord::Migration
  def change
    rename_table :attributes, :kattributes
  end
end
