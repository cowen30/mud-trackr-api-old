class User < ApplicationRecord
	validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true, on: :create
	validates :email, uniqueness: { case_sensitive: false }
	validates :password,
		length: { minimum: 8 },
		format: { with: /[A-Z]/, message: 'must contain at least one uppercase character' },
		confirmation: true,
		if: :password_digest_changed?
	validates :password, format: { with: /[!@#$%^&*]/, message: 'must contain at least one special character' }, if: :password_digest_changed?
	has_secure_password

	def to_builder
		Jbuilder.new do |user|
			user.(self, :id, :first_name, :last_name, :email, :active, :created_at, :updated_at)
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
