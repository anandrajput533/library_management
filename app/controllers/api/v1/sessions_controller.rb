module Api
	module V1
		class SessionsController < Api::V1::ApplicationController
			before_action :authorize_request, only: :logout
			skip_before_action :verify_authenticity_token
			
			def login
				@user = User.find_by_email(params[:user][:email])
			  if @user&.valid_password?(params[:user][:password])
			  	token = JsonWebToken.encode(user_id: @user.id)
			  	time = Time.now + 24.hours.to_i
			  	sign_in(@user)
			  	render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),message: "User successfully login", email: @user.email }, status: :ok
			   else
			  	render json: {message: "Invalid user or password"}, status: :unprocessable_entity
			  end
		  end

			def logout
				reset_session
				current_user = nil
				render json: {message: "User successfully logout"}
			end
 		end
 	end
end