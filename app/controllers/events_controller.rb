# frozen_string_literal: true

class EventsController < ApplicationController

	skip_before_action :require_login, only: %i[index show]

	def index
		@events = Event.where(archived: false).order(date: :desc)
	end

	def show
		@event = Event.find(params[:id])
	end

	def create
		@event = Event.new(event_params)
		@current_user = User.find(current_user_id)
		@event.created_by = @current_user
		@event.updated_by = @current_user
		unless @event.save
			render json: { message: 'An unexpected error has occurred.' }, status: :internal_server_error
		end
	end

	private

	def event_params
		params.deep_transform_keys!(&:underscore).require(:event).permit(:name, :brand_id, :address, :city, :state, :country, :date)
	end

end
