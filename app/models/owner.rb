class Owner < ActiveRecord::Base

	has_many :entries


	def self.find_or_create_by_attributes(attributes) 

		owner = Owner.where(attributes).first

		if owner.present?

			return owner

		end

		return Owner.create(attributes)
		
	end

end
