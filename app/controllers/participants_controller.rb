# frozen_string_literal: true

class ParticipantsController < ApplicationController

	skip_before_action :require_login, only: %i[show_users]

	def show_users
		@participants = Participant.includes(event_detail: %i[event]).where(user_id: params[:id]).order(Arel.sql('events.date DESC'), Arel.sql('participants.participation_day DESC'))
	end

end
