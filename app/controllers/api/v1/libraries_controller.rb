module Api
  module V1
    class LibrariesController < ApplicationController
      before_action :authorize_request
      skip_before_action :verify_authenticity_token
      before_action :my_lib , only:[:show,:update,:destroy,:create]

      def show
        if @library.present?
         render json: @library
         else
          render json: {message:"No library found"}
        end
      end

      def create
        if @library.present?
          render json: {message: "you can create only one Library"}
        else
          @lib = current_user.build_library(params_lib)
          @lib.save
          render json: @lib
        end
      end

      def update
        if @library.present?
          @library.update(params_lib)
          render json: @library
        else
          render json: {message: "Library is not found"}
        end
      end

      def destroy
        if @library.present?
          @library.destroy
          render json: {message: "Library deleted successfully "}
        else
          render json: {message: "Library is not found"}
        end
      end
      private

      def params_lib
        params.require(:library).permit(:library_name, :library_address)
      end
      
      def my_lib
        @library = current_user.library
      end
    end
  end
end
