class Jockey < ActiveRecord::Base

	JOCKEY_NUMBER_OF_RACES = "COUNT(jockeys.id)"

	JOCKEY_WIN_ROI_SELECT = "( (sum(entries.win_payoff) - (2 * count(jockeys.id))) / (2 * count(jockeys.id) ) )"
	JOCKEY_PLACE_ROI_SELECT = "( (sum(entries.place_payoff) - (2 * count(jockeys.id))) / (2 * count(jockeys.id) ) )"
	JOCKEY_SHOW_ROI_SELECT = "( (sum(entries.show_payoff) - (2 * count(jockeys.id))) / (2 * count(jockeys.id) ) )"

	JOCKEY_NUMBER_OF_WINS = "SUM(CASE WHEN CAST(entries.official_finish as int) = 1 THEN 1 ELSE 0 END)"
	JOCKEY_NUMBER_OF_PLACES = "SUM(CASE WHEN CAST(entries.official_finish as int) = 2 THEN 1 ELSE 0 END)"
	JOCKEY_NUMBER_OF_SHOWS = "SUM(CASE WHEN CAST(entries.official_finish as int) = 3 THEN 1 ELSE 0 END)"

	scope :with_win_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("jockeys.id").
		select("CAST(#{JOCKEY_WIN_ROI_SELECT} as decimal(10,2)) as win_roi,jockeys.*,jockeys.id, #{JOCKEY_NUMBER_OF_WINS} as wins, #{JOCKEY_NUMBER_OF_RACES} as total_races").
		order("win_roi DESC")
	}

	scope :with_place_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("jockeys.id").
		select("CAST(#{JOCKEY_PLACE_ROI_SELECT} as decimal(10,2)) as place_roi,jockeys.*,jockeys.id, #{JOCKEY_NUMBER_OF_PLACES} as places, #{JOCKEY_NUMBER_OF_RACES} as total_races").
		order("place_roi DESC")
	}

	scope :with_show_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("jockeys.id").
		select("CAST(#{JOCKEY_SHOW_ROI_SELECT} as decimal(10,2)) as show_roi,jockeys.*,jockeys.id, #{JOCKEY_NUMBER_OF_SHOWS} as shows, #{JOCKEY_NUMBER_OF_RACES} as total_races").
		order("show_roi DESC")
	}

	scope :distinct_tracks, -> {
		from("charts").
		select("track_name").distinct
	}		
	
	has_many :entries


	def self.find_or_create_by_attributes(attributes) 

		jockey = Jockey.where(attributes).first

		if jockey.present?

			return jockey

		end

		return Jockey.create(attributes)
		
	end

end
