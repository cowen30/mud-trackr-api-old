# frozen_string_literal: true

class LoginController < ApplicationController

	skip_before_action :require_login, only: %i[create]

	def create
		@user = User.find_by('lower(email) = ?', user_params[:email].downcase)
		if @user && @user.authenticate(user_params[:password])
			render :create, locals: { token: token(@user) }
		else
			render json: { errors: [ 'Invalid username or password' ] }, status: :unprocessable_entity
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password)
	end

end
