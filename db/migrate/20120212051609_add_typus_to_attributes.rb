class AddTypusToAttributes < ActiveRecord::Migration
  def change
    add_column :attributes, :typus, :string
  end
end
