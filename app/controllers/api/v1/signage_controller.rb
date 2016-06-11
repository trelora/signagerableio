module Api
  module V1
    class SignageController < ApiController
      respond_to :json

      def index
        response = {time: time, signs: signs}
        respond_with JSON.generate(response)
      end

      private
        def time
          Display.find(1).time * 1000
        end

        def signs
          service = TreloraServices.new

          role = Device.find_by(device_code: cookies[:device_code]).role

          service.house_listing(role)
        end
    end
  end
end
