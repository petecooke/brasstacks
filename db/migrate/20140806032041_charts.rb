class Charts < ActiveRecord::Migration
  def change
  	add_column :charts, :chart, :string
  end
end
