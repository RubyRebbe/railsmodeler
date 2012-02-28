class AddAppToKassociations < ActiveRecord::Migration
		def up
			change_table :kassociations do |t|
		  	t.references :app
			end
		end

		def down
			remove_column :kassociations, :app
		end
end


