# frozen_string_literal: true

class UsersController < ApplicationController

	skip_before_action :require_login, only: %i[reset]

	def show
		@user = User.find(params[:id])
	end

	def reset
		@user = User.find_by(id: params[:id], reset_code: params[:resetCode])
		render :show
	end

	def destroy
		@user = User.find(params[:id])
		unless can_delete_user(@user.id)
			render json: {
				message: 'Not authorized to delete account'
			}, status: :unauthorized
			return
		end
		if @user.update(active: false)
			render json: {
				message: 'Account successfully deleted'
			}, status: :no_content
		end
	end

	private

	def can_delete_user(user_id)
		return true if current_user_id == user_id

		current_user.user_roles.map do |role|
			return true if [1, 2].inlcude? role.role_id
		end
		false
	end

end
