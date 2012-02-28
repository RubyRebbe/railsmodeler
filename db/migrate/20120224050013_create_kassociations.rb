class CreateKassociations < ActiveRecord::Migration
  def change
    create_table :kassociations do |t|
      t.string :typus
      t.text :description
      t.references :source
      t.references :target

      t.timestamps
    end
    add_index :kassociations, :source_id
    add_index :kassociations, :target_id
  end
end
