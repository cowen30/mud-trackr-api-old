# frozen_string_literal: true

class AuthController < ApplicationController

	skip_before_action :require_login, only: %i[create login]

	def login
		@user = User.find_by('lower(email) = ?', login_params[:email].downcase)
		if @user&.authenticate(login_params[:password])
			render :login, locals: { token: token(@user) }
		else
			render json: { errors: ['Invalid username or password'] }, status: :unauthorized
		end
	end

	private

	def login_params
		params.require(:user).permit(:email, :password)
	end

end
