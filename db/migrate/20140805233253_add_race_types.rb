class AddRaceTypes < ActiveRecord::Migration
  def change
  	add_column :charts, :race_type, :string
  end
end
