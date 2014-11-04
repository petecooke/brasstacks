class RaceLevel < ActiveRecord::Base

	scope :distinct_race_levels, -> {
		joins({:races => [:chart,:race_level]}).
		group("charts.track_name, race_levels.id").
		select("charts.track_name, race_levels.race_type, race_levels.restriction, cast(race_levels.distance as int) / 100 as distance, race_levels.dist_unit, race_levels.surface, race_levels.class_rating, race_levels.id").
		order("race_levels.class_rating DESC")
	}

	scope :distinct_tracks, -> {
		from("charts").
		select("track_name").distinct
	}			

	has_many :races

	def self.find_or_create_by_attributes(attributes) 

		race_level = RaceLevel.where(attributes).first

		if race_level.present?

			return race_level

		end

		return RaceLevel.create(attributes)
		
	end

end
