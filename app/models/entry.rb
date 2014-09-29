class Entry < ActiveRecord::Base

	belongs_to :race
	belongs_to :horse
	belongs_to :jockey
	belongs_to :trainer
	belongs_to :owner

end
