class ApplicationController < ActionController::API
	include ActionController::Helpers
	helper EmailHelper

	before_action :require_login

	private

	def token(user)
		payload = { user: user.slice('id', 'first_name', 'last_name') }
		JWT.encode(payload, hmac_secret, 'HS256')
	end

	def hmac_secret
		ENV['API_SECRET_KEY']
	end

	def client_has_valid_token?
		!!current_user_id
	end

	def current_user
		User.find(current_user_id)
	end

	def current_user_id
		begin
			token = request.headers['Authorization'].split.last
			decoded_array = JWT.decode(token, hmac_secret, true, { algorithm: 'HS256' })
			payload = decoded_array.first
		rescue
			return nil
		end
		payload['user']['id']
	end

	def require_login
		render json: { error: 'Unauthorized' }, status: :unauthorized unless client_has_valid_token?
	end

end
