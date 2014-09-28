class RenameOwnerColumn < ActiveRecord::Migration
  def change
  	rename_column :owners, :owner, :owner_name
  end
end
