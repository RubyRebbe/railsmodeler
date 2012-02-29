class AddKassociationToKlasses < ActiveRecord::Migration
  def change
    add_column :klasses, :kassociation_id, :integer
  end
end
