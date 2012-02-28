require 'spec_helper'

describe Klass do
	before( :all) do
		Klass.destroy_all; Kattribute.destroy_all

		@video = Klass.create( :name => "Video")
		@video.kattributes.create( :name => "title", :typus => "string")
		@video.kattributes.create( :name => "artist", :typus => "string")

		@person = Klass.create( :name => "Person")
		@person.kattributes.create( :name => "name", :typus => "string")
	end

  it "can create a Klass with a name" do
		@video.name.should == "Video"
	end

	it "Klass Video has attribute title of type string" do
	  @video.kattributes.count.should be 2
		a = @video.kattributes.where( :name => "title" ).first
		a.name.should == "title" && a.typus.should == "string"
	end

	it "Klass Video has attribute artist of type string" do
	  @video.kattributes.count.should be 2
		a = @video.kattributes.where( :name => "artist").first
		a.name.should == "artist" && a.typus.should == "string"
	end

	it "Klass video should scaffold in the context of its attributes" do
		@video.to_scaffold.strip.should == "rails generate scaffold Video title:string artist:string"
	end

	it "can create a Person Klass" do
		@person.name.should == "Person"
	end

	it "Klass Person has a name attribute of type string" do
		a = @person.kattributes.where( :name => "name").first
		a.name.should == "name" && a.typus.should == "string"
	end
	
	describe "Video belongs_to Person and scaffolding" do
		before( :all) do
			@assoc = Kassociation.create( :typus => "belongs_to", :source => @video, :target => @person )
		end

		it "can construct a belongs_to association between Video and Person" do
			@assoc.typus.should == "belongs_to"
			@assoc.source.name.should == "Video" && @assoc.target.name.should == "Person"
		end

		it "Klass Video can see the association" do
			@video.sources.count.should == 1
			@video.sources.first.should == @assoc
		end

		it "Klass Video scaffolds properly in the context of the association" do
			@video.to_scaffold.should =~ /person:references/
			@video.to_scaffold.strip.should == 
				"rails generate scaffold Video title:string artist:string person:references"
		end
	end # describe Video belongs_to Person and scaffolding

	describe "Person has_many Videos and scaffolding" do
		before( :all) do
			Kassociation.destroy_all
			@assoc = Kassociation.create(:typus => "has_many", :source => @person, :target => @video)
		end

		it "there is only one association" do
			Kassociation.count.should == 1
		end

		it "Person scaffolding should have no references" do
			@person.to_scaffold.should_not =~ /:references/
		end

		it "Video scaffold contains person:references precisely once" do
			@video.to_scaffold.should =~ /person:references/
			@video.to_scaffold.strip.should ==
				"rails generate scaffold Video title:string artist:string person:references"
		end
	end # describe Person has_many Videos and scaffolding

	describe "Person has_many Videos and Video belongs_to Person and scaffold" do
		before( :all) do
			Kassociation.destroy_all
			@has_many = Kassociation.create(:typus => "has_many", :source => @person, :target => @video)
			@belongs_to = Kassociation.create(:typus => "belongs_to", 
				:source => @video, :target => @person)
		end

		it "there are exactly 2 associations:" do
			puts Kassociation.all.map { |ka| ka.name }
			Kassociation.count.should == 2
		end

		it "Person scaffolding should have no references" do
			@person.to_scaffold.should_not =~ /:references/
		end

		it "union of source and target contributions to scaffold" do
			so = @video.sources.map { |ka| ka.to_scaffold_source }
			so.should == ["person:references"]
			ta = @video.targets.map { |ka| ka.to_scaffold_target }
			ta.should == ["person:references"]
			(so|ta).should == ["person:references"]
		end

		it "Video scaffold contains person:references precisely once" do
			puts @video.to_scaffold
			@video.to_scaffold.should =~ /person:references/
			@video.to_scaffold.strip.should ==
				"rails generate scaffold Video title:string artist:string person:references"
		end
	end # describe Person has_many Videos and Video belongs_to Person and scaffold
end # describe Klass
