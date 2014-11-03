class Trainer < ActiveRecord::Base

	# TRAINER_ROI_SELECT = "( sum(entries.win_payoff) - (2 * count(trainers.id)) / (2 * count(trainers.id) ) )"

	# TRAINER_DISTANCE_CONVERSION = "( race_levels.distance / 100 )"

	# scope :with_win_roi, -> {
	# 	joins({:entries => {:race => [:chart,:race_level]}}).
	# 	group("charts.track_name, race_levels.id, trainers.id").
	# 	select("trainers.last_name, trainers.suffix, trainers.first_name, trainers.middle_name, #{TRAINER_ROI_SELECT} as win_roi, charts.track_name, race_levels.race_type, race_levels.restriction, cast(race_levels.distance as int) / 100 as distance, race_levels.dist_unit, race_levels.surface, race_levels.class_rating, count(trainers.id) as total_races,trainers.*,trainers.id").
	# 	order("win_roi DESC, trainers.last_name, trainers.first_name, race_levels.class_rating DESC")
	# }

	# # scope :distinct_tracks, -> {joins({:entries => {:race => [:chart,:race_level]}}).group("charts.track_name, trainers.id").select("trainers.id, charts.track_name")}
	# scope :distinct_tracks, -> {
	# 	from("charts").
	# 	select("track_name").distinct
	# }

	# scope :distinct_race_levels, -> {
	# 	joins({:entries => {:race => [:chart,:race_level]}}).
	# 	group("charts.track_name, race_levels.id").
	# 	select("charts.track_name, race_levels.race_type, race_levels.restriction, cast(race_levels.distance as int) / 100 as distance, race_levels.dist_unit, race_levels.surface, race_levels.class_rating, race_levels.id").
	# 	order("race_levels.class_rating DESC")
	# }	



	TRAINER_NUMBER_OF_RACES = "COUNT(trainers.id)"

	TRAINER_WIN_ROI_SELECT = "( (sum(entries.win_payoff) - (2 * count(trainers.id))) / (2 * count(trainers.id) ) )"
	TRAINER_PLACE_ROI_SELECT = "( (sum(entries.place_payoff) - (2 * count(trainers.id))) / (2 * count(trainers.id) ) )"
	TRAINER_SHOW_ROI_SELECT = "( (sum(entries.show_payoff) - (2 * count(trainers.id))) / (2 * count(trainers.id) ) )"

	TRAINER_NUMBER_OF_WINS = "SUM(CASE WHEN CAST(entries.official_finish as int) = 1 THEN 1 ELSE 0 END)"
	TRAINER_NUMBER_OF_PLACES = "SUM(CASE WHEN CAST(entries.official_finish as int) = 2 THEN 1 ELSE 0 END)"
	TRAINER_NUMBER_OF_SHOWS = "SUM(CASE WHEN CAST(entries.official_finish as int) = 3 THEN 1 ELSE 0 END)"

	scope :with_win_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("trainers.id").
		select("CAST(#{TRAINER_WIN_ROI_SELECT} as decimal(10,2)) as win_roi,trainers.*,trainers.id, #{TRAINER_NUMBER_OF_WINS} as wins, #{TRAINER_NUMBER_OF_RACES} as total_races").
		order("win_roi DESC")
	}

	scope :with_place_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("trainers.id").
		select("CAST(#{TRAINER_PLACE_ROI_SELECT} as decimal(10,2)) as place_roi,trainers.*,trainers.id, #{TRAINER_NUMBER_OF_PLACES} as places, #{TRAINER_NUMBER_OF_RACES} as total_races").
		order("place_roi DESC")
	}

	scope :with_show_roi, -> {
		joins({:entries => {:race => [:chart,:race_level]}}).
		group("trainers.id").
		select("CAST(#{TRAINER_SHOW_ROI_SELECT} as decimal(10,2)) as show_roi,trainers.*,trainers.id, #{TRAINER_NUMBER_OF_SHOWS} as shows, #{TRAINER_NUMBER_OF_RACES} as total_races").
		order("show_roi DESC")
	}

	scope :distinct_tracks, -> {
		from("charts").
		select("track_name").distinct
	}		

	has_many :entries


	def self.find_or_create_by_attributes(attributes) 

		trainer = Trainer.where(attributes).first

		if trainer.present?

			return trainer

		end

		return Trainer.create(attributes)
		
	end

end


