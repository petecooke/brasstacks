class XmlFiles < ActiveRecord::Migration
  def change
  	add_column :charts, :XmlFiles, :string
  end
end
