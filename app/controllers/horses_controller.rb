class HorsesController < ApplicationController
	def index
		@horses = Horse.order("horse_name ASC").all
	end		
end
