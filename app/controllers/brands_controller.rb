# frozen_string_literal: true

class BrandsController < ApplicationController

	def index
		@brands = Brand.all.order(id: :asc)
	end

end
