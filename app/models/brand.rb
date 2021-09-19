class Brand < ApplicationRecord
	belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by'

	def to_builder
		Jbuilder.new do |brand|
			brand.(self, :id, :name)
			brand.updated_by updated_by.to_builder
		end
	end
end
