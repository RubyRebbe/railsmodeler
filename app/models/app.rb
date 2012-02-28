class App < ActiveRecord::Base
	has_many :klasses, :dependent => :destroy
	has_many :kassociations, :dependent => :destroy

	def self.databases
		[ "sqlite3", "postgresql", "mysql", "oracle", "frontbase", "ibm_db" ]
	end

	def to_scaffold
		"rails new " + self.name + " --database " + self.database
	end
end
