class Klass < ActiveRecord::Base
	belongs_to :app
	has_many :attributes

	def to_scaffold
		prefix = "rails generate scaffold " + self.name
		self.attributes.reduce( prefix ) { |memo,a|
			memo + " " + a.name + ":" + a.typus
		}
	end
end

