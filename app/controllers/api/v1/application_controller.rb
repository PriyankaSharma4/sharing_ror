class Api::V1::ApplicationController < ActionController::API
	before_action :set_api_format
	# skip_before_filter :verify_authenticity_token 
	before_action :authenticate_api_user
  	
  	# before_action :check_pre_requirements

	def logged_in?
		!!session_user
	end

	def authenticate_api_user
		unless logged_in?
			render json: {error: 'Please Login'}, status: :unauthorized and return
		end
	end

	def session_user
		decode_hash = decoded_token
		
		if !decode_hash.empty?
			user_id = decode_hash[0]['user_id']

			@current_api_user = User.find_by(id: user_id)
		else
			nil
		end
	end

	def auth_header
		request.headers['Authorization']
	end

	def decoded_token
		if auth_header
			token = auth_header
			puts "token ----- #{token}"
			begin
				JWT.decode(token,Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
			rescue JWT::DecodeError
				[]
			end
		else
			[]
		end
	end



	def set_api_format
		request.format = :json
	end



end