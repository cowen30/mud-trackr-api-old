# frozen_string_literal: true

class EventsController < ApplicationController

	def index
        @events = Event.where(archived: false).order(date: :desc)
    end

end
