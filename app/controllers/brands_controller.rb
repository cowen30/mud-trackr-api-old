# frozen_string_literal: true

class BrandsController < ApplicationController

	skip_before_action :require_login, only: %i[index show]

	def index
		@brands = Brand.all.order(id: :asc)
	end

	def show
		@brand = Brand.find(params[:id])
	end

end
