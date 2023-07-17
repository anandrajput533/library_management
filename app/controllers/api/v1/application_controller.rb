require 'json_web_token'

class Api::V1::ApplicationController < ActionController::Base
  # include DeviseTokenAuth::Concerns::SetUserByToken

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue Exception => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end