json.array! @brands do |brand|
	json.merge! brand.to_builder.attributes!
end
