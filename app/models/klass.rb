class Klass < ActiveRecord::Base
	belongs_to :app
	has_many :kattributes

	def to_scaffold
		puts "*"*80
		puts "BEGIN Klass.to_scaffold: #{self}"

		prefix = "rails generate scaffold " + self.name
		puts "prefix:  #{prefix}"
		puts "number of attributes: #{self.kattributes.length}"

		self.kattributes.reduce( prefix ) { |memo,a|
			memo + " " + a.name + ":" + a.typus
		}
	end
end

