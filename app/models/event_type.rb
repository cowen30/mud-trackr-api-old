class EventType < ApplicationRecord
	belongs_to :brand, :class_name => 'Brand', :foreign_key => 'brand_id'

	def to_builder_short
		Jbuilder.new do |event_type|
			event_type.(self, :id, :name, :short_name, :display_order)
			event_type.brand brand.to_builder
		end
	end

end
