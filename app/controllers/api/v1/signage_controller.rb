module Api
  module V1
    class SignageController < ApiController
      respond_to :json

      def index

        device = Device.find_by(device_code: cookies[:device_code])
        if device.blank?
          redirect_to '/' # new device
        else
          device.seen!
        end

        role = device.role
        sign = Slide.where(api_role: role).order("RANDOM()").first.to_json

        response = {time: time, sign: JSON.parse(sign)}
        respond_with JSON.generate(response)
      end

      private

      def time
        Display.find(1).time * 1000
      end

    end
  end
end
