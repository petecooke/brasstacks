class RemoveXmlFiles < ActiveRecord::Migration
  def change
  	remove_column :charts, :XmlFiles
  end
end
