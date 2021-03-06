class ChartsController < ApplicationController

	before_action :authenticate_user!
	before_action :require_admin, :only => [:new, :create, :index, :show, :destroy_all]

	def new
		@chart = Chart.new
	end

	def create
		@chart = Chart.create(chart_params)

		redirect_to root_path
	end

	def index
		@charts = Chart.all
	end

	def show
		@chart = Chart.find(params[:id])
	end

	def destroy_all
		Chart.destroy_all
		RaceLevel.destroy_all
		Jockey.destroy_all
		Trainer.destroy_all
		Owner.destroy_all
		Horse.destroy_all

		redirect_to charts_path
	end

	def chart_params
		params.require(:chart).permit(:race_date, :track_name, :race_number, :entry_name, :official_finish, :race_type, :xmlFile, :chart)
	end

end

