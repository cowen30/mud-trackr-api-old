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

end
