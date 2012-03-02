require 'spec_helper'

describe App do
	before( :all) do
		[ App, Klass, Kassociation ].each { |kl| kl.delete_all }

		@app = App.create( :name => "business", :database => "postgresql" )
		@person = @app.klasses.create( :name => "Person" )
		@company = @app.klasses.create( :name => "Company")
		@jassoc = @app.kassociations.create( :typus => "join", :source => @person, :target => @company)

		@heredoc = <<-EOF
class Foobar
	def initialize
		initialize_foobar
	end

	def get_foo(x)
		puts "get while the getting is good"
	end
end
EOF
	end

	it "can generate the appropriate file names for model classes, including join classes" do
		klass_names = Klass.all.map { |klass| klass.name }.sort
		klass_names.should == [ "Company", "Person", "PersonCompany"]
		file_names = klass_names.map { |kn| kn.tableize.singularize + ".rb" }
		file_names.should == %w(company.rb person.rb person_company.rb)
	end

	it "experimental class scaffold and code generation" do
		model_dir = "app/models/"

		puts Klass.all.map { |klass| 
			[ klass.to_scaffold, klass.name.tableize.singularize, klass.to_s ] 
		}. map { |triple|
			[
				triple[0], <<-EOF
File.open( #{model_dir + triple[1]}, "w") { |f|
	f.write( "#{triple[2]}" )
}
				EOF
			]
		}
	end

	it "ruby here document works as advertised" do
		puts "Current directory:  #{Dir.pwd}"

		var = "bad"

		s = <<-EOF
class Foobar
	def initialize
		initialize_foobar
	end

	def get_foo(x)
		puts "get while the getting is" + #{var}
	end
end
EOF

		puts s
	end

	it "can write a here document to a file" do
		File.open( "foobar.txt", "w") do |f|
			f.write @heredoc
		end

		f = File.new( "foobar.txt", "r")
		contents = f.read
		f.close
		File.delete( "foobar.txt")

		contents.should == @heredoc
	end

	it "the railsmodeler app can generate a ruby script which generates the app for real" do
		puts @app.to_code
	end
end
