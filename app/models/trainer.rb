class Trainer < ActiveRecord::Base

	has_many :entries


	def self.find_or_create_by_attributes(attributes) 

		trainer = Trainer.where(attributes).first

		if trainer.present?

			return trainer

		end

		return Trainer.create(attributes)
		
	end

end


