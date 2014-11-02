class AddChartFingerprint < ActiveRecord::Migration

  def change
  	add_column :charts, :fingerprint, :string

  	add_index :charts, :fingerprint
  end


end
