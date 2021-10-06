class Participant < ApplicationRecord

	belongs_to :event_detail
	belongs_to :user, class_name: 'User', foreign_key: 'user_id'
	belongs_to :created_by, class_name: 'User', foreign_key: 'created_by'
	belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by'

	accepts_nested_attributes_for :event_detail, reject_if: :check_event_detail

	def to_builder
		Jbuilder.new do |participant|
			participant.(self, :id, :participation_day)
			participant.user user.to_builder_short
			participant.event_detail event_detail.to_builder_short
			participant.created_at created_at
			# participant.created_by created_by.to_builder_short
			participant.updated_at updated_at
			participant.updated_by updated_by.to_builder_short
		end
	end

	protected

	def check_event_detail(event_detail_attr)
		event_detail = EventDetail.find_or_create_by(event_id: event_detail_attr[:event_id], event_type_id: event_detail_attr[:event_type_id])
		self.event_detail = event_detail
	end

end
