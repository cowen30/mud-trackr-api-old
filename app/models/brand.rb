class Brand < ApplicationRecord
	belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by'

	def to_builder
		Jbuilder.new do |brand|
			brand.(self, :id, :name)
			if logo_path.blank?
				brand.logo_path nil
			else
				brand.logo_path brand.logo_path
			end
			brand.updated_by updated_by.to_builder_short
		end
	end
end
