class EventDetail < ApplicationRecord
	belongs_to :event, class_name: 'Event', foreign_key: 'event_id'
	belongs_to :event_type, class_name: 'EventType', foreign_key: 'event_type_id'
	belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by', optional: true

	def to_builder_short
		Jbuilder.new do |event_detail|
			event_detail.(self, :id, :lap_distance, :lap_elevation)
			event_detail.event event.to_builder_short
			event_detail.event_type event_type.to_builder_short
			# event_detail.updated_by updated_by.to_builder_short
			event_detail.created_at created_at
			event_detail.updated_at updated_at
		end
	end

end
