class CreateRaces < ActiveRecord::Migration
  def change
    create_table :races do |t|

    	t.integer :chart_id

    	t.integer :number
    	t.string  :breed
    	t.string  :race_type
    	t.string  :restriction
    	t.string  :distance
    	t.string  :dist_unit
    	t.string  :surface
    	t.string  :condition

    	t.timestamps

    end
  end
end
