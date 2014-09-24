class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
			t.string "first_name"
			t.string "middle_name"
			t.string "last_name"
			t.string "suffix"
			t.integer "key"
			t.string "trainer_type"
			t.timestamps
  	end

  	remove_column :entries, :trainer_first_name
  	remove_column :entries, :trainer_last_name

  	add_column :entries, :trainer_id, :integer

  	add_index :entries, :trainer_id

  end
end
