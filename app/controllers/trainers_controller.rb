class TrainersController < ApplicationController

	def index
		@trainers = Trainer.order("last_name ASC").all
	end	
end

