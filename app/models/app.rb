class App < ActiveRecord::Base
	has_many :klasses

	def self.databases
		[ "sqlite3", "postgresql", "mysql", "oracle", "frontbase", "ibm_db" ]
	end

	def to_scaffold
		"rails new " + self.name + " --database " + self.database
	end
end
