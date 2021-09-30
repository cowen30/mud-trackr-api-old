class User < ApplicationRecord
	has_secure_password

	def to_builder
		Jbuilder.new do |user|
			user.(self, :id, :first_name, :last_name, :email, :active)
		end
	end

	def to_builder_short
		Jbuilder.new do |user|
			user.(self, :id, :first_name, :last_name)
		end
	end

	def full_name
		"#{first_name} #{last_name}"
	end
end
