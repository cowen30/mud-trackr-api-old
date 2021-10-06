json.array! @event_types do |event_type|
	json.merge! event_type.to_builder_short.attributes!
end
