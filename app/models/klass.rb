class Klass < ActiveRecord::Base
	belongs_to :app
	belongs_to :kassociation # not nil if this a join class
	has_many :kattributes, :dependent => :destroy
	
	# returns list of Kassociations where this klass is the source
	def sources
		Kassociation.where( :source_id => self.id )
	end

	# returns list of Kassociations where this klass is the target
	def targets
		Kassociation.where( :target_id => self.id )
	end

	def direction( kassoc)
		dir = "" # a little dummy proofing
		if kassoc.source.id == self.id then
			dir = "source"
		elsif kassoc.target.id == self.id then
			dir = "target"
		end
		dir
	end

	def to_scaffold
		prefix = "rails generate scaffold " + self.name
		kats = self.kattributes.map { |a| a.to_scaffold }
		so = self.sources.map { |ka| ka.to_scaffold_source }
		ta = self.targets.map { |ka| ka.to_scaffold_target }

		( kats + (so|ta) ).reduce( prefix) { |m,s| m + " " + s }
	end

	# generates the code for the class as an array of strings
	# for display on webpage, deals with the fact html ignores whitespace, notably newline
	def to_code
		self.kassociation == nil ?  # source code for non-join class
			[
				"class #{self.name} < ActiveRecord::Base",
				( self.sources.map { |kassoc| kassoc.to_code_source } | 
					self.targets.map { |kassoc| kassoc.to_code_target } ).flatten,
				"end"
			]
		: self.kassociation.to_code_join	# source code for join class
	end

	def to_s
		code = self.to_code
		"#{code[0]} #{code[1].reduce( "") { |m,s| m + "\n  " + s }} \n#{code[2]}"
	end
end

