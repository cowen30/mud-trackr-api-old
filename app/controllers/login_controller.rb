# frozen_string_literal: true

class LoginController < ApplicationController

	skip_before_action :require_login, only: %i[create]

	def create
		@user_query = User.where('lower(email) = ?', user_params[:email].downcase).select(:id, :password_digest)
		@user = @user_query.first
		if @user && @user.authenticate(user_params[:password])
			@user = @user_query.reselect(:id, :first_name, :last_name).first
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
