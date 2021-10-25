# frozen_string_literal: true

class AuthController < ApplicationController
	skip_before_action :require_login, only: %i[create login verify]

	def create
		@user = User.new(user_params)
		unless @user.valid?
			render json: {
				message: @user.errors.objects.first.full_message
			}, status: :bad_request
			return
		end
		if @user.save
			ApplicationController.helpers.send_welcome_email @user
			render :create, locals: { token: token(@user) }
		else
			puts @user.errors.full_messages
			render json: {
				message: 'An unexpected error has occurred.'
			}, status: :internal_server_error
		end
	end

	def login
		@user = User.find_by('lower(email) = ?', login_params[:email].downcase)
		if @user&.authenticate(login_params[:password])
			render :login, locals: { token: token(@user) }
		else
			render json: {
				message: 'Invalid username or password'
			}, status: :unauthorized
		end
	end

	def verify
		@user = User.find(params[:userId])
		verification_code = params[:verificationCode]
		if verification_code == @user.verification_code
			@user.verification_code = nil
			@user.active = true
			@user.updated_by = @user.id
			unless @user.save
				puts @user.errors.full_messages
				render json: {
					message: 'An unexpected error has occurred.'
				}, status: :internal_server_error
			end
		else
			render json: {
				message: 'Invalid verification code'
			}, status: :unauthorized
		end
	end

	private

	def user_params
		params.deep_transform_keys!(&:underscore).require(:user).permit(:email, :password, :first_name, :last_name, :password, :password_confirmation)
	end

	def login_params
		params.require(:user).permit(:email, :password)
	end

end
