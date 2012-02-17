class AddReferenceToKlasses < ActiveRecord::Migration
  def change
    add_column :klasses, :app_id, :integer
  end
end
