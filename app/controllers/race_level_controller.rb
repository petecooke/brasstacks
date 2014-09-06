class RaceLevelController < ApplicationController

	def show
		@racelevel= Chart.show
	end

end
