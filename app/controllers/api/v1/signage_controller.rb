module Api
  module V1
    class SignageController < ApiController
      respond_to :json

      def index
        service = TreloraServices.new

        role = Device.find_by(device_code: cookies[:device_code]).role

        respond_with service.house_listing(role)
      end
    end
  end
end
