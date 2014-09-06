class Race < ActiveRecord::Base
	belongs_to :chart
	belongs_to :race_level

	has_many :entries
end
