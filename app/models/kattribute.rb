class Kattribute < ActiveRecord::Base # to avoid conflict with ActiveRecord.attributes method
  belongs_to :klass

	def self.types # rails db types
	[
		"string",
		"text",
		"integer",
		"float",
		"decimal",
		"datetime",
		"timestamp",
		"time",
		"date",
		"binary",
		"boolean"
	]
	end

	def to_scaffold
		self.name + ":" + self.typus
	end
end
