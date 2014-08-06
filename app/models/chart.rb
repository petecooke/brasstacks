class Chart < ActiveRecord::Base
	mount_uploader :chart, ChartUploader
end
