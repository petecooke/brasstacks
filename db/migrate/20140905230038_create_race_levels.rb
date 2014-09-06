class CreateRaceLevels < ActiveRecord::Migration
  def change
    create_table :race_levels do |t|
	    t.string   "race_type"
	    t.string   "restriction"
	    t.string   "distance"
	    t.string   "dist_unit"
	    t.string   "surface"
    t.timestamps
    end

    remove_column :races, :race_type
    remove_column :races, :restriction
    remove_column :races, :distance
    remove_column :races, :dist_unit
    remove_column :races, :surface

    add_column :races, :race_level_id, :integer

    add_index :races, :race_level_id
  end
end
