# frozen_string_literal: true

class EventTypesController < ApplicationController

	skip_before_action :require_login, only: %i[index show]

	def index
		@event_types = EventType.all.order(display_order: :asc)
	end

end
