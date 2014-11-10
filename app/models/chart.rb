class Chart < ActiveRecord::Base
	has_many :races, :dependent => :destroy
	
	before_create :parse_xml
	before_validation :generate_fingerprint

	mount_uploader :chart, ChartUploader

	def generate_fingerprint

		self.fingerprint = Digest::SHA1.hexdigest(chart_data)

	end

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

			#RACE LEVEL
			race_type = element.css('TYPE').first.content
			restriction = element.css('AGE_RESTRICTIONS').first.content
			distance = element.css('DISTANCE').first.content
			dist_unit = element.css('DIST_UNIT').first.content
			surface = element.css('COURSE_DESC').first.content	
			class_rating = element.css('CLASS_RATING').first.content

			race_level = RaceLevel.find_or_create_by_attributes(
				:race_type => race_type,
				:restriction => restriction,
				:distance => distance,
				:dist_unit => dist_unit,
				:surface => surface,
				:class_rating => class_rating
			)	

			#RACE
			# race = self.races.create(
			race = self.races.build(
				:race_level_id => race_level.id,
				:number =>  element['NUMBER'].to_i,
				:breed => element.css('BREED').first.content,
				:condition => element.css('TRK_COND').first.content,
				:meet_season => "Fall", # TOTAL CHEAT HERE ... hardcoded until functionality is added
				:race_date => doc.css('CHART').first['RACE_DATE'].to_date,
				:track_name => doc.css('CHART TRACK NAME')[0].content
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
				 element.css('CLASS_RATING').first.content + "\n\t" +
				 "Track Condition: " + element.css('TRK_COND').first.content

				# ENTRY
			 	element.css('ENTRY').each do |sub|

			 		# JOCKEY
					jockey_first_name = sub.css('JOCKEY FIRST_NAME').first.content
					jockey_middle_name = sub.css('JOCKEY MIDDLE_NAME').first.content
					jockey_last_name = sub.css('JOCKEY LAST_NAME').first.content
					jockey_suffix = sub.css('JOCKEY SUFFIX').first.content
					jockey_key = sub.css('JOCKEY KEY').first.content
					# jockey_type = sub.css('JOCKEY TYPE').first.content

					jockey = Jockey.find_or_create_by_attributes(
						:first_name => jockey_first_name,
						:middle_name => jockey_middle_name,
						:last_name => jockey_last_name,
						:suffix => jockey_suffix,
						:key => jockey_key,
						# :jockey_type => jockey_type

					)

					# TRAINER
					trainer_first_name = sub.css('TRAINER FIRST_NAME').first.content
					trainer_middle_name = sub.css('TRAINER MIDDLE_NAME').first.content
					trainer_last_name = sub.css('TRAINER LAST_NAME').first.content
					trainer_suffix = sub.css('TRAINER SUFFIX').first.content
					trainer_key = sub.css('TRAINER KEY').first.content
					trainer_type = sub.css('TRAINER TYPE').first.content

					trainer = Trainer.find_or_create_by_attributes(
						:first_name => trainer_first_name,
						:middle_name => trainer_middle_name,
						:last_name => trainer_last_name,
						:suffix => trainer_suffix,
						:key => trainer_key,
						:trainer_type => trainer_type
					)	

					# OWNER
					owner_name = sub.css('OWNER').first.content

					owner = Owner.find_or_create_by_attributes(
						:owner_name => owner_name
					)

					# HORSE
					horse_name = sub.css('NAME').first.content

					horse = Horse.find_or_create_by_attributes(
						:horse_name => horse_name
					)					

					# RACE ENTRY
			 		# race.entries.create(
			 		race.entries.build(
			 			:jockey => jockey,
			 			:trainer => trainer,
			 			:owner => owner,
			 			:horse => horse,
			 			:program_num => sub.css('PROGRAM_NUM').first.content.to_i,
						# :name => sub.css('NAME').first.content,
						:age => sub.css('AGE').first.content.to_i,
						:meds => sub.css('MEDS').first.content,
						:equip => sub.css('EQUIP').first.content,
						:odds => sub.css('DOLLAR_ODDS').first.content.to_f,
						:official_finish => sub.css('OFFICIAL_FIN').first.content.to_i,
						:speed_rating => sub.css('SPEED_RATING').first.content.to_i,
						# :jockey_first_name => sub.css('JOCKEY FIRST_NAME').first.content,
						# :jockey_last_name => sub.css('JOCKEY LAST_NAME').first.content,
						# :trainer_first_name => sub.css('TRAINER FIRST_NAME').first.content,
						# :trainer_last_name => sub.css('TRAINER LAST_NAME').first.content,
						# :owner => sub.css('OWNER').first.content,
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
