class CreateCharts < ActiveRecord::Migration
  def change
    create_table :charts do |t|
    	t.date :race_date
    	t.text :track_name
    	t.integer :race_number
    	t.text :entry_name
    	t.integer :official_finish
      t.timestamps
    end

  end
end
