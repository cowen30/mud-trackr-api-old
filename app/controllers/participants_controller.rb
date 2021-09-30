# frozen_string_literal: true

class ParticipantsController < ApplicationController

	skip_before_action :require_login, only: %i[show_users]

	def show_users
		@participants = Participant.includes(event_detail: %i[event event_type]).where(user_id: params[:id]).order(Arel.sql('events.date DESC'), Arel.sql('participants.participation_day DESC'), Arel.sql('event_types.display_order ASC'))
	end

end
