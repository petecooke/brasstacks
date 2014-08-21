class RemoveXmlFiles < ActiveRecord::Migration
  def change
  	remove_column :charts, :XmlFilesc
  end
end
