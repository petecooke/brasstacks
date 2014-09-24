class JockeysController < ApplicationController

	def index
		@jockeys = Jockey.order("last_name ASC").all
	end

end
