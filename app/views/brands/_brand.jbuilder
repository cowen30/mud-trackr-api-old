json.id brand.id
json.name brand.name

if brand.logo_path.nil?
	json.logo_url nil
else
	json.logo_url "#{request.base_url}#{ActionController::Base.helpers.image_path(brand.logo_path)}"
end
json.updated_by brand.updated_by.to_builder
json.created_at brand.created_at
json.updated_at brand.updated_at
