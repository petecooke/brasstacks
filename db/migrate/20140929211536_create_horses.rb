class CreateHorses < ActiveRecord::Migration
  def change
    create_table :horses do |t|
    	t.string "horse_name"
	    t.timestamps
    end

    remove_column :entries, :name

    add_column :entries, :horse_id, :integer

    add_index :entries, :horse_id
  end
end

