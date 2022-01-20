class EventType < ApplicationRecord
	belongs_to :brand

	def to_builder_short
		Jbuilder.new do |event_type|
			event_type.(self, :id, :name, :short_name, :display_order)
			event_type.brand brand.to_builder
		end
	end

end
