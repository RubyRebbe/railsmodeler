class App < ActiveRecord::Base
	has_many :klasses, :dependent => :destroy
	has_many :kassociations, :dependent => :destroy

	def self.databases
		[ "sqlite3", "postgresql", "mysql", "oracle", "frontbase", "ibm_db" ]
	end

	def to_scaffold
		"rails new " + self.name + " --database " + self.database
	end

	# generates an array of strings which constitutes the entire code generation for the app
	def to_code
		prefix = [ 
			"#!/usr/bin/ruby", 
			"system( \"#{self.to_scaffold}\")", 
			"Dir.chdir \"#{self.name}\"" 
		]

		self.klasses.reduce( prefix) { |m,klass| 
			m << "system( \"#{klass.to_scaffold}\")" << klass_to_file(klass)
		} << "rake db:create" << "rake db:migrate"
	end

	def klass_to_file( klass)
		<<-EOF
# generate model class #{klass.name}
f = File.new( "app/models/#{klass.name.tableize.singularize}.rb", "w")
f.write <<-EOKLASS
#{klass.to_s}
EOKLASS
f.close

EOF
	end

	def gen_klass( file_name, code)
		File.open( "app/models/#{file_name}.rb", "w") { |f|
			f.write code
		}
	end
end
