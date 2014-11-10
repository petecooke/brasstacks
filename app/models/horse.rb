class Horse < ActiveRecord::Base

	HORSE_NUMBER_OF_RACES = "COUNT(horses.id)"

	HORSE_WIN_ROI_SELECT = "( (sum(entries.win_payoff) - (2 * count(horses.id))) / (2 * count(horses.id) ) )"
	HORSE_PLACE_ROI_SELECT = "( (sum(entries.place_payoff) - (2 * count(horses.id))) / (2 * count(horses.id) ) )"
	HORSE_SHOW_ROI_SELECT = "( (sum(entries.show_payoff) - (2 * count(horses.id))) / (2 * count(horses.id) ) )"

	HORSE_NUMBER_OF_WINS = "SUM(CASE WHEN CAST(entries.official_finish as int) = 1 THEN 1 ELSE 0 END)"
	HORSE_NUMBER_OF_PLACES = "SUM(CASE WHEN CAST(entries.official_finish as int) = 2 THEN 1 ELSE 0 END)"
	HORSE_NUMBER_OF_SHOWS = "SUM(CASE WHEN CAST(entries.official_finish as int) = 3 THEN 1 ELSE 0 END)"

	scope :with_win_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("horses.id").
		select("CAST(#{HORSE_WIN_ROI_SELECT} as decimal(10,2)) as win_roi,horses.*,horses.id, #{HORSE_NUMBER_OF_WINS} as wins, #{HORSE_NUMBER_OF_RACES} as total_races").
		order("win_roi DESC")
	}

	scope :with_place_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("horses.id").
		select("CAST(#{HORSE_PLACE_ROI_SELECT} as decimal(10,2)) as place_roi,horses.*,horses.id, #{HORSE_NUMBER_OF_PLACES} as places, #{HORSE_NUMBER_OF_RACES} as total_races").
		order("place_roi DESC")
	}

	scope :with_show_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("horses.id").
		select("CAST(#{HORSE_SHOW_ROI_SELECT} as decimal(10,2)) as show_roi,horses.*,horses.id, #{HORSE_NUMBER_OF_SHOWS} as shows, #{HORSE_NUMBER_OF_RACES} as total_races").
		order("show_roi DESC")
	}

	scope :distinct_tracks, -> {
		from("charts").
		select("track_name").distinct
	}	

	scope :horses_9yo_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("horses.id, entries.age").
		select("CAST(#{HORSE_WIN_ROI_SELECT} as decimal(10,2)) as win_roi,horses.*,horses.id, #{HORSE_NUMBER_OF_WINS} as wins, #{HORSE_NUMBER_OF_RACES} as total_races, entries.age").
		order("win_roi DESC")		
	}

	has_many :entries

	def number_of_wins

		# self.entries.where(:official_entry => [1,2,3])
		# self.entries.where("official_entry != 1")
		# self.entries.where("official_entry != ?", user_input)
		self.entries.where(:official_finish => "1").count
		
	end

	def self.find_or_create_by_attributes(attributes) 

		horse = Horse.where(attributes).first

		if horse.present?

			return horse

		end

		return Horse.create(attributes)
		
	end

end

