# frozen_string_literal: true

class AuthController < ApplicationController
	skip_before_action :require_login, only: %i[create login verify reset new_password]

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

	def reset
		@user = User.find_by('lower(email) = ?', reset_params[:email].downcase)
		if @user.nil?
			render json: {
				message: 'User account not found'
			}, status: :bad_request
		else
			ApplicationController.helpers.send_password_reset_email @user
			render json: {}, status: :no_content
		end
	end

	def new_password
		@user = User.find(new_password_params[:id])
		if !@user.nil? && new_password_params[:reset_code] == @user.reset_code
			if @user.update(new_password_params.merge(reset_code: nil))
				render json: {
					message: 'Password successfully changed'
				}, status: :ok
			else
				puts @user.errors.full_messages
				render json: {
					message: 'An unexpected error has occurred.'
				}, status: :internal_server_error
			end
		else
			render json: {
				message: 'User account not found or invalid reset code'
			}, status: :bad_request
		end
	end

	private

	def user_params
		params.deep_transform_keys!(&:underscore).require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
	end

	def login_params
		params.require(:user).permit(:email, :password)
	end

	def reset_params
		params.deep_transform_keys!(&:underscore).require(:user).permit(:email, :reset_code)
	end

	def new_password_params
		params.deep_transform_keys!(&:underscore).require(:user).permit(:id, :email, :reset_code, :password, :password_confirmation)
	end

end
