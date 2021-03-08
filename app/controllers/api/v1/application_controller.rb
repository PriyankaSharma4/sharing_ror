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


	def authenticate_api_user_old
		begin
			if current_user.present?
				@current_api_user = current_user
			else
				raise "Please add apisecret in headers" if request.headers["HTTP_APISECRET"].blank?
				puts request.headers["HTTP_APISECRET"]
				@current_api_user=User.find_by_api_secret(request.headers["HTTP_APISECRET"])
				raise "user_not_found" if @current_api_user.nil?

			end
		rescue Exception => @e
				err_hash={}
				err_hash[:error]=@e.message
				render :json => err_hash.to_json, status: :unauthorized
		end
	end

	def authenticate_doctor
		begin
			raise "Sorry! You are not authorized." unless @current_api_user.role == 1
		rescue Exception => @e
			err_hash={}
			err_hash[:error]=@e.message
			render :json => err_hash.to_json, status: :unauthorized
		end
	end

	def set_api_format
		request.format = :json
	end



end