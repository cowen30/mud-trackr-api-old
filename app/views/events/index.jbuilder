json.array! @events do |event|
	json.merge! event.to_builder_short.attributes!
end
