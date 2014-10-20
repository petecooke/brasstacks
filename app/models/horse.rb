class Horse < ActiveRecord::Base

	HORSE_ROI_SELECT = "( sum(entries.win_payoff) - (2 * count(horses.id)) / (2 * count(horses.id) ) )"
	# HORSE_NUMBER_OF_WINS = self.entries.where(:official_finish => "1").count
	# HORSE_NUMBER_OF_WINS = Entry.where(:official_finish => "1").count
	# HORSE_NUMBER_OF_WINS = "(count(entries.official_finish))"
	HORSE_NUMBER_OF_WINS = "SUM(CASE WHEN CAST(entries.official_finish as int) = 1 THEN 1 ELSE 0 END)"

	scope :with_win_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("horses.id").
		select("CAST(#{HORSE_ROI_SELECT} as decimal(10,2)) as win_roi,count(horses.id) as total_races,horses.*,horses.id, #{HORSE_NUMBER_OF_WINS} as wins").
		order("win_roi DESC")
	}

	scope :distinct_tracks, -> {
		from("charts").
		select("track_name").distinct
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

