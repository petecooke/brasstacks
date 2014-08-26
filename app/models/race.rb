class Race < ActiveRecord::Base
	belongs_to :chart

	has_many :entries
end
