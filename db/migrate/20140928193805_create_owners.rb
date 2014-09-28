class CreateOwners < ActiveRecord::Migration
  def change
    create_table :owners do |t|
    	t.string "owner"
	    t.timestamps
    end

    remove_column :entries, :owner

    add_column :entries, :owner_id, :integer

    add_index :entries, :owner_id
  end
end

