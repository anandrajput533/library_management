module Api
	module V1
		module Base
			extend ActiveSupport::Concern
			include {respond_to :json}
		end
	end
end