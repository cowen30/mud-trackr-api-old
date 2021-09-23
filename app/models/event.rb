class Event < ApplicationRecord
	belongs_to :brand

	belongs_to :created_by, class_name: 'User', foreign_key: 'created_by'
	belongs_to :approved_by, class_name: 'User', foreign_key: 'approved_by', optional: true
	belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by'

	def to_builder
		Jbuilder.new do |event|
			event.(self, :id, :name, :address, :city, :state, :country, :date)
			event.brand brand.to_builder
			event.created_at created_at
			event.created_by created_by.to_builder
			event.updated_at updated_at
			event.updated_by updated_by.to_builder
		end
	end

	def to_builder_short
		Jbuilder.new do |event|
			event.(self, :id, :name, :address, :city, :state, :country, :date)
		end
	end
end
