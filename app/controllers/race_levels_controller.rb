class RaceLevelsController < ApplicationController

	def index
		@racelevels = RaceLevel.order("class_rating DESC").all
	end

end
