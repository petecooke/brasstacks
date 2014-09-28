class OwnersController < ApplicationController
	def index
		@owners = Owner.order("owner_name ASC").all
	end	
end
