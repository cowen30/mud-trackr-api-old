# frozen_string_literal: true

class ParticipantsController < ApplicationController

	skip_before_action :require_login, only: %i[show_users]

	def show_users
		@participants = Participant.includes(event_detail: %i[event event_type]).where(user_id: params[:id]).order(Arel.sql('events.date DESC'), Arel.sql('participants.participation_day DESC'), Arel.sql('event_types.display_order ASC'))
	end

	def create
		@participant = Participant.new(participant_params)
		@current_user = User.find(current_user_id)
		@participant.created_by = @current_user
		@participant.updated_by = @current_user
		unless @participant.save
			puts @participant.errors.full_messages
			render json: { message: 'An unexpected error has occurred.' }, status: :internal_server_error
		end
	end

	def update
		@participant = Participant.find(params[:id])
		@current_user = User.find(current_user_id)
		@participant.updated_by = @current_user
		unless @participant.update(participant_params.merge(updated_by: @current_user))
			puts @participant.errors.full_messages
			render json: { message: 'An unexpected error has occurred.' }, status: :internal_server_error
		end
	end

	def destroy
		@participant = Participant.find(params[:id])
		unless @participant.destroy
			puts @participant.errors.full_messages
			render json: { message: 'An unexpected error has occurred.' }, status: :internal_server_error
		end
	end

	private

	def participant_params
		params.deep_transform_keys!(&:underscore).require(:participant).permit(:id, :user_id, { event_detail_attributes: %i[event_id event_type_id] }, :participation_day)
	end

end
