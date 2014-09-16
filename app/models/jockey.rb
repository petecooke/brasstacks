class Jockey < ActiveRecord::Base
	
	has_many :entries


	def self.find_or_create_by_attributes(attributes) 

		jockey = Jockey.where(attributes).first

		if jockey.present?

			return jockey

		end

		return Jockey.create(attributes)
		
	end

end
