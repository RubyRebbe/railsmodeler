class Kassociation < ActiveRecord::Base
	belongs_to :source, :class_name => "Klass", :foreign_key => "source_id"
	belongs_to :target, :class_name => "Klass", :foreign_key => "target_id"
	belongs_to :app

	def self.types # association types
	[
		"belongs_to",
		"has_many",
		"has_many through"
	]
	end

	def name
		"#{source.name} #{typus} #{target.name}"
	end

	def to_scaffold_source
		# assume for now:  typus == belongs_to OR has_many
		case self.typus
			when "belongs_to"													# prototype:  Video belongs_to Person
				self.target.name.downcase + ":references"	# result:	"person:references"
			when "has_many"															# prototype:	Video has_many Song
				""																				# result:			""
			else
				""
		end
	end

	def to_scaffold_target
		# assume for now:  typus == belongs_to OR has_many
		case self.typus
			when "belong_to"													# prototype:  Video belongs_to Person
				""																				# result:			""
			when "has_many"															# prototype:  Video has_many Song
				self.source.name.downcase + ":references"	# result: "video:references"
			else
				""
		end
	end

	def to_code_source
		# assume for now:  typus == belongs_to OR has_many
		case self.typus
			when "belongs_to"																				# prototype:  Video belongs_to Person
				"belongs_to :" + self.target.name.downcase					# result:	"belongs_to :person"
			when "has_many"																					# prototype:	Video has_many Song
				"has_many :" + self.target.name.downcase.pluralize	# result:	"has_many :songs"
			else
				""
		end
	end

	def to_code_target
		case self.typus
			when "belongs_to"														# prototype:  Video belongs_to Person
				""																				# result:	""
			when "has_many"															# prototype:	Video has_many Song
				"belongs_to :" + self.source.name.downcase	# result:	"belongs_to :video"
			else
				""
		end		
	end
end # class Kassociation


