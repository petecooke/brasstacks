class CreateJockeys < ActiveRecord::Migration
  def change
    create_table :jockeys do |t|
			t.string "first_name"
			t.string "middle_name"
			t.string "last_name"
			t.string "suffix"
			t.integer "key"
			t.string "type"
			t.timestamps
  	end

  	remove_column :entries, :jockey_first_name
  	remove_column :entries, :jockey_last_name

  	add_column :entries, :jockey_id, :integer

  	add_index :entries, :jockey_id

  end
end
