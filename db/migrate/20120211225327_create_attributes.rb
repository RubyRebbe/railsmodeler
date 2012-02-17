class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :name
      t.text :description
      t.references :klass

      t.timestamps
    end
    add_index :attributes, :klass_id
  end
end
