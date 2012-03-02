class Kassociation < ActiveRecord::Base
	belongs_to :source, :class_name => "Klass", :foreign_key => "source_id"
	belongs_to :target, :class_name => "Klass", :foreign_key => "target_id"
	belongs_to :app

	after_create do
		if self.typus == "join" then
			self.create_join_class
		end
	end

	before_destroy do
		if self.typus == "join" then
			if self.join_class != nil then
				self.join_class.destroy
			end
		end
	end

	# pre-condition:  typus == "join"
	def join_class
		Klass.where( :kassociation_id => self.id).first
	end

	def self.types # association types
	[
		"belongs_to",
		"has_many",
		"join",							# adding in join frees me to be creative, not bound by rails convention
		"has_many through"	# for has_many through
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
			when "join"
				[ 
					"has_many :#{join_table_name}",
					"has_many :#{target.name.downcase.pluralize}, :through => :#{join_table_name}"
				]
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
			when "join"
				[ 
					"has_many :#{join_table_name}",
					"has_many :#{source.name.downcase.pluralize}, :through => :#{join_table_name}"
				]
			else
				""
		end		
	end

	def join_table_name
		source.name.downcase + "_" + target.name.downcase.pluralize
	end

	# generates the code of the join class
	# pre-condition:  self.typus == "join"
	# may not be needed: it's the join class's responsibility as a Klass
	# subject to rspec test
	def to_code_join
		[
			"class #{join_class_name} < ActiveRecord::Base",
			[
				"belongs_to :" + self.source.name.downcase,
				"belongs_to :" + self.target.name.downcase
			],
			"end"
		]
	end

	# creates the join class within the app in railsmodeler
	# pre-condition:  self.typus == "join"
	def create_join_class
		j_class = self.app.klasses.create( :name => join_class_name, :kassociation => self )

		[ self.source.name.downcase, self.target.name.downcase ].each { |n|
			join_class.kattributes.create( :name => n, :typus => "references" )
		}

		j_class
	end

	def join_class_name
		self.source.name + self.target.name
	end
end # class Kassociation


