class Chart < ActiveRecord::Base
	
	before_create :parse_xml

	mount_uploader :chart, ChartUploader

	def chart_data
		self.chart.read
	end

	def parse_xml

		# Get a Nokogiri::XML::Document for the page we’re interested in...

		doc = Nokogiri::XML(chart_data)

		# Do funky things with it using Nokogiri::XML::Node methods...

		####
		# Search for nodes by css
		element = doc.css('CHART TRACK NAME')[0]

		self.track_name = element.content

		puts self.track_name
		
		# screen dump
		# puts element.content

		# loop through file

		doc.css('CHART RACE').each do |element|

			puts "\tRace Number: " + element['NUMBER']

			puts "\t" + 
				 "Breed: " + element.css('BREED').first.content + "\n\t" +
				 "Race Type: " + element.css('TYPE').first.content + "\n\t" +
				 "Restriction: " + element.css('AGE_RESTRICTIONS').first.content  + "\n\t" +
				 "Distance: " + element.css('DISTANCE').first.content + 
				 element.css('DIST_UNIT').first.content + " " +
				 element.css('COURSE_DESC').first.content + "\n\t" +
				 "Track Condition: " + element.css('TRK_COND').first.content

			 	element.css('ENTRY').each do |sub|
			 		puts "\t" + 
			 			sub.css('PROGRAM_NUM').first.content + " " +
			 			sub.css('NAME').first.content + ": " +
			 			sub.css('AGE').first.content + "yrs " +
			 			sub.css('MEDS').first.content +
			 			sub.css('EQUIP').first.content + " " +
			 			"(" + sub.css('DOLLAR_ODDS').first.content + " odds)" + " " +
		 				"Finished: " + sub.css('OFFICIAL_FIN').first.content + " " +
		 				"Speed Rating: " + sub.css('SPEED_RATING').first.content + "\n\t\t" +
	 					"Jockey: " + sub.css('JOCKEY FIRST_NAME').first.content + " " +
	 					sub.css('JOCKEY LAST_NAME').first.content + ", " +
	 					"Trainer: " + sub.css('TRAINER FIRST_NAME').first.content + " " +
	 					sub.css('TRAINER LAST_NAME').first.content + ", " +
	 					"Owner: " + sub.css('OWNER').first.content + "\n\t\t" +
	 					"Comment: " + sub.css('COMMENT').first.content + "\n\t\t" +
	 					"Payoff: " +
	 					"Win: $" + sub.css('WIN_PAYOFF').first.content + 
	 					" Place: $" + sub.css('PLACE_PAYOFF').first.content +
	 					" Show: $" + sub.css('SHOW_PAYOFF').first.content +
	 					" (Show 2: $" + sub.css('SHOW_PAYOFF2').first.content + ")"



			 	end

			puts "\n"
		end

		# save the change
		# self.save

	end

end
