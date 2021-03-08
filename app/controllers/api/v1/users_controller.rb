class Api::V1::UsersController < Api::V1::ApplicationController 

	before_action :authenticate_api_user , except: [:sign_up,:login]

	def sign_up
		begin
			raise "Email already present" if User.find_by_email(params[:user][:email].downcase).present?
			user = User.create!(user_params)
			payload = {user_id:  user.id , email: user.email}
		    token = encode_token(payload)
			hash={}
			hash[:message]="User register successfully"
			hash[:token] = token
			render :json => hash.to_json
		rescue Exception => e
			render json: { error: "something went wrong" }, status: :bad_request and return					

		end
	end

	def login

		begin
		user = User.find_by(email: params[:user][:email])
	  	raise "Email or Password is incorrect" if user.nil?
	  	
	  	if user.valid_password?(params[:user][:password])
	  		payload = {user_id:  user.id , email: user.email}
		    token = encode_token(payload)
			hash={}
			hash[:message]="User register successfully"
			hash[:token] = token
			
			render :json => hash.to_json
	  	else
	  		raise "Email or Password is incorrect" 
	  	end
	  		
		rescue Exception => e
			render json: { error: e }, status: :bad_request and return	
		end
		
	end


	def all_users
		begin
			users = User.all.where.not(id: @current_api_user.id)
			hash={}
			hash[:users] = users.as_json
			render :json => hash.to_json

		rescue Exception => e
			render json: { error: "something went wrong" }, status: :bad_request and return	

		end
	end

	def create_user_location_share
		begin
			
			share_location = @current_api_user.location_shares.create!(location_params)
			

			if(params[:selected_users].count>0)
				params[:selected_users].map{|x| 
				share_location.shared_to_others.create!(user_id: x[:id])}				
			end

			hash={}
			hash[:message] = "location share successfully."
			render :json => hash.to_json

		rescue Exception => e
				render json: { error: e }, status: :bad_request and return	
		end

	end

	def dashboard
		begin

			hsh = {}
			hsh[:shared_by_me] = @current_api_user.location_shares.as_json
			hsh[:shared_by_others] = @current_api_user.shared_to_others.as_json(methods: [:location_share])

			render :json => hsh.to_json

		rescue Exception => e
			render json: { error: "something went wrong" }, status: :bad_request and return	
		end

	end

	def public_location
		begin
			user = User.find_by(id: params[:id])
			location = user.location_shares.where(is_public: true)
			hsh = {}
			hsh[:user] = user.email
			hsh[:public_locations] = location.as_json

			render :json => hsh.to_json
		rescue Exception => e
			render json: { error: "something went wrong" }, status: :bad_request and return	

		end

	end
	
	private

		def user_params
			params.require(:user).permit(:email,:password)
		end

		def location_params
			params.require(:location).permit(:user_id,:lat, :long, :address, :is_public)
		end

		def encode_token(payload)
			JWT.encode(payload,Rails.application.secrets.secret_key_base)
		end

end
