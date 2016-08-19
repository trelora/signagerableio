module Api
  module V1
    class SignageController < ApiController
      respond_to :json

      def index
        response = {time: time, sign: JSON.parse(sign)}
        respond_with JSON.generate(response)
      end

      private
        def time
          Display.find(1).time * 1000
        end

        def sign
          role = Device.find_by(device_code: cookies[:device_code]).role
          Slide.where(api_role: role).order("RANDOM()").first.to_json
        end
    end
  end
end
