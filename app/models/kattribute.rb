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
		"boolean",
		"references",
		"through"		# not a rails db type, but an rmodel type
	]
	end
end
