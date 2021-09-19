json.array! @events do |event|
	json.id event.id
	json.name event.name
	json.address event.address
	json.city event.city
	json.state event.state
	json.country event.country
	json.date event.date
	json.brand event.brand.to_builder
	json.created_by event.created_by.to_builder
	json.created_at event.created_at
	json.updated_by event.updated_by.to_builder
	json.updated_at event.updated_at
end
