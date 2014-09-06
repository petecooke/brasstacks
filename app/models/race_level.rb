class RaceLevel < ActiveRecord::Base

	has_many :races

	def self.find_or_create_by_attributes(attributes) 

		race_level = RaceLevel.where(attributes)

		if race_level.present?

			return race_level

		end

		return RaceLevel.create(attributes)
		
	end

end
