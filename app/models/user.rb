class User < ApplicationRecord
	validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true
	validates :email, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 8 }, confirmation: true
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
