class AddSeasonToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :meet_season, :string
  end
end
