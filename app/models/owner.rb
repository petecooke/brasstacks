class Owner < ActiveRecord::Base

	OWNER_NUMBER_OF_RACES = "COUNT(owners.id)"

	OWNER_WIN_ROI_SELECT = "( (sum(entries.win_payoff) - (2 * count(owners.id))) / (2 * count(owners.id) ) )"
	OWNER_PLACE_ROI_SELECT = "( (sum(entries.place_payoff) - (2 * count(owners.id))) / (2 * count(owners.id) ) )"
	OWNER_SHOW_ROI_SELECT = "( (sum(entries.show_payoff) - (2 * count(owners.id))) / (2 * count(owners.id) ) )"

	OWNER_NUMBER_OF_WINS = "SUM(CASE WHEN CAST(entries.official_finish as int) = 1 THEN 1 ELSE 0 END)"
	OWNER_NUMBER_OF_PLACES = "SUM(CASE WHEN CAST(entries.official_finish as int) = 2 THEN 1 ELSE 0 END)"
	OWNER_NUMBER_OF_SHOWS = "SUM(CASE WHEN CAST(entries.official_finish as int) = 3 THEN 1 ELSE 0 END)"

	scope :with_win_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("owners.id").
		select("CAST(#{OWNER_WIN_ROI_SELECT} as decimal(10,2)) as win_roi,owners.*,owners.id, #{OWNER_NUMBER_OF_WINS} as wins, #{OWNER_NUMBER_OF_RACES} as total_races").
		order("win_roi DESC")
	}

	scope :with_place_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("owners.id").
		select("CAST(#{OWNER_PLACE_ROI_SELECT} as decimal(10,2)) as place_roi,owners.*,owners.id, #{OWNER_NUMBER_OF_PLACES} as places, #{OWNER_NUMBER_OF_RACES} as total_races").
		order("place_roi DESC")
	}

	scope :with_show_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("owners.id").
		select("CAST(#{OWNER_SHOW_ROI_SELECT} as decimal(10,2)) as show_roi,owners.*,owners.id, #{OWNER_NUMBER_OF_SHOWS} as shows, #{OWNER_NUMBER_OF_RACES} as total_races").
		order("show_roi DESC")
	}

	scope :distinct_tracks, -> {
		from("charts").
		select("track_name").distinct
	}		

	has_many :entries


	def self.find_or_create_by_attributes(attributes) 

		owner = Owner.where(attributes).first

		if owner.present?

			return owner

		end

		return Owner.create(attributes)
		
	end

end
