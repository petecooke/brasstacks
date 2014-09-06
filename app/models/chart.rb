class Chart < ActiveRecord::Base
	has_many :races
	
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

		self.race_date = doc.css('CHART').first['RACE_DATE'].to_date

		puts self.track_name




		# screen dump
		# puts element.content

		# loop through file

		doc.css('CHART RACE').each do |element|

			race_type = element.css('TYPE').first.content
			restriction = element.css('AGE_RESTRICTIONS').first.content
			distance = element.css('DISTANCE').first.content
			dist_unit = element.css('DIST_UNIT').first.content
			surface = element.css('COURSE_DESC').first.content	

			race_level = RaceLevel.find_or_create_by_attributes(
				:race_type => race_type,
				:restriction => restriction,
				:distance => distance,
				:dist_unit => dist_unit,
				:surface => surface
			)	

			# race = self.races.create(
			race = self.races.build(
				:race_level_id => race_level.id,
				:number =>  element['NUMBER'].to_i,
				:breed => element.css('BREED').first.content,
				:condition => element.css('TRK_COND').first.content
			)

			# console output
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

			 		# race.entries.create(
			 		race.entries.build(
			 			:program_num => sub.css('PROGRAM_NUM').first.content.to_i,
						:name => sub.css('NAME').first.content,
						:age => sub.css('AGE').first.content.to_i,
						:meds => sub.css('MEDS').first.content,
						:equip => sub.css('EQUIP').first.content,
						:odds => sub.css('DOLLAR_ODDS').first.content.to_f,
						:official_finish => sub.css('OFFICIAL_FIN').first.content.to_i,
						:speed_rating => sub.css('SPEED_RATING').first.content.to_i,
						:jockey_first_name => sub.css('JOCKEY FIRST_NAME').first.content,
						:jockey_last_name => sub.css('JOCKEY LAST_NAME').first.content,
						:trainer_first_name => sub.css('TRAINER FIRST_NAME').first.content,
						:trainer_last_name => sub.css('TRAINER LAST_NAME').first.content,
						:owner => sub.css('OWNER').first.content,
						:comment => sub.css('COMMENT').first.content,
						:win_payoff => sub.css('WIN_PAYOFF').first.content.to_f,
						:place_payoff => sub.css('PLACE_PAYOFF').first.content.to_f,
						:show_payoff => sub.css('SHOW_PAYOFF').first.content.to_f,
						:show_payoff2 => sub.css('SHOW_PAYOFF2').first.content.to_f
			 		)

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

		element = doc.css('CHART').first['RACE_DATE'].to_date

		puts "race date: " + element.to_s  #self.race_date

		# save the change
		# self.save

	end

end
