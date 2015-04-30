class AnalyticsController < ApplicationController
	def index

		respond_to do |format|
			format.html
			format.pdf do            
				render  :pdf => "Analisis.pdf", :template => 'analytics/pdf.html.erb', :javascript_delay => 2000
			end
		end

	end

end