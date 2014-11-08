class AddDateTrackToRaces < ActiveRecord::Migration
  def change
  	add_column :races, :race_date, :date
  	add_column :races, :track_name, :string
  end
end
