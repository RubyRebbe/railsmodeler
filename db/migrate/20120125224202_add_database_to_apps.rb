class AddDatabaseToApps < ActiveRecord::Migration
  def change
    add_column :apps, :database, :string
  end
end
