class Event < ApplicationRecord
	belongs_to :brand

	belongs_to :created_by, class_name: 'User', foreign_key: 'created_by'
	belongs_to :approved_by, class_name: 'User', foreign_key: 'approved_by', optional: true
	belongs_to :updated_by, class_name: 'User', foreign_key: 'updated_by'
end
