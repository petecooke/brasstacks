class AddClassRatingToRaceLevels < ActiveRecord::Migration
  def change
  	add_column :race_levels, :class_rating, :integer
  end
end
