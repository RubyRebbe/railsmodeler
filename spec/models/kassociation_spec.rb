require 'spec_helper'

describe Kassociation do
  describe "Join Class" do
		before( :all) do
			@app = App.create( :name => "business")
			@person = @app.klasses.create( :name => "Person" )
			@company = @app.klasses.create( :name => "Company")
			@jassoc = @app.kassociations.create( :typus => "join", :source => @person, :target => @company)
			@jclass = @jassoc.join_class
		end

		it "the join class exists and was created by the join association at its creation" do
			@jclass.should_not == nil
			@jclass.name.should == "PersonCompany"
		end

		it "the join association associates Person with Company" do
			@jassoc.source.name.should == "Person"
			@jassoc.target.name.should == "Company"
		end

		it "join association belongs to App business" do
			@jassoc.app.name.should == "business"
		end

		it "the join association can generate the join class with the correct name" do
			@jclass.name.should == @jassoc.source.name + @jassoc.target.name
		end

		it "the join class belongs to App business" do
			@jclass.app.name.should == "business"
		end

		it "the kassociation of a non-join class is nil" do
			currency = @app.klasses.create( :name => "Currency" )
			currency.kassociation.should == nil
		end

		it "the kassociation of the join class is not nil" do
			@jclass.kassociation.should_not == nil
		end

		it "the kassociation of the join class is the association that spawned it" do
			@jclass.kassociation.should == @jassoc
		end

		it "the join class has precisely 2 attributes" do
			@jclass.kattributes.count.should == 2
		end

		it "each attribute of the join class has the type:  references" do
			@jclass.kattributes.map { |a| a.typus }.should == [ "references", "references" ]
		end

		it "the attributes of the join class have the correct downcased class names" do
			@jclass.kattributes.map { |a| a.name }.sort.should == [ "company", "person" ]
		end

		it "the join class scaffolds properly" do
			@jclass.to_scaffold.should == 
				"rails generate scaffold PersonCompany person:references company:references"
		end

		it "the join class generates the proper source code" do
			@jclass.to_code.should == [
				"class PersonCompany < ActiveRecord::Base",
				["belongs_to :person", "belongs_to :company"],
				"end"
			]
		end
	end # describe Join Class"

	describe "Person join Company: to_code" do
		before( :all) do
			@app = App.create( :name => "business")
			@person = @app.klasses.create( :name => "Person" )
			@company = @app.klasses.create( :name => "Company")
			@jassoc = @app.kassociations.create( :typus => "join", :source => @person, :target => @company)
			@jclass = @jassoc.join_class
		end

		it "Person generates the right source code:  has_many and through" do
			@person.to_code.should == [
				"class Person < ActiveRecord::Base", 
				["has_many :person_companies", "has_many :companies, :through => :person_companies"], 
				"end"
			]
		end

		it "Company generates the right source code:  has_many and through" do
			@company.to_code.should == [
				"class Company < ActiveRecord::Base", 
				["has_many :person_companies", "has_many people, :through => :person_companies"],
				"end"
			]
		end
	end
end # describe Kassociation
