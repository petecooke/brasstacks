class Horse < ActiveRecord::Base

	has_many :entries


	def self.find_or_create_by_attributes(attributes) 

		horse = Horse.where(attributes).first

		if horse.present?

			return horse

		end

		return Horse.create(attributes)
		
	end

end


