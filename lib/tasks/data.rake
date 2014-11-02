namespace :data do
  desc "TODO"
  task import: :environment do
  	Dir.foreach(Rails.root.join('data','charts').to_s) do |item|
  		next if item == '.' or item == '..'
  			puts Rails.root.join('data','charts', item).to_s
		end
  end

end
