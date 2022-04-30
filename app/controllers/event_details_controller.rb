# frozen_string_literal: true

class EventDetailsController < ApplicationController

	skip_before_action :require_login, only: %i[index show]

	def show
		@event_detail = EventDetail.find(params[:id])
	end

end
