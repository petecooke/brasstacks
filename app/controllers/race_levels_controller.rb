class RaceLevelsController < ApplicationController

	def index
		@racelevels = RaceLevel.all
	end

end
