class PerformancesController < ApplicationController

	def show
		render template: "performances/#{params[:view]}"
	end

end
