require 'json_web_token'

module Api
	module V1
		class RegistrationsController < Devise::RegistrationsController
			# skip_before_action :verify_authenticity_token
			def create
				@user = User.new(params_user)
				if @user.save
					token = JsonWebToken.encode(user_id: @user.id)
		      time = Time.now + 24.hours.to_i
		      sign_in(@user)
		      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),message: "User successfully created", email: @user.email }, status: :ok
				else
		      render json: {message: "User already Sign existed"}, status: :unprocessable_entity
				end
			end

			private
			def params_user
				params.require(:user).permit(:email, :password, :password_confirmation)
			end
		end
	end
end