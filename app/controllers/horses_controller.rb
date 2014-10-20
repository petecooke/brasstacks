class HorsesController < ApplicationController
	def index

		@horses = Horse.order("horse_name ASC").all

		# @entries = Entry.all

		# @entries = Entry.find(params[:id])

	end	


end
