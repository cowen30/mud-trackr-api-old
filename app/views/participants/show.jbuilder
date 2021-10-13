json.array! @participants do |participants|
	json.merge! participants.to_builder.attributes!
end
