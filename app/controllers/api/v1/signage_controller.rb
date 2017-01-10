module Api
  module V1
    class SignageController < ApiController
      respond_to :json

      def index

        device = Device.find_by(device_code: cookies[:device_code])
        if device.blank?
          device = create_device
        else
          device.seen!
        end

        role = device.role
        sign = Slide.where('api_role = ? OR custom = ?', role, true)
          .order("RANDOM()").first.to_json

        response = {
          time: time,
          show_device_codes: show_device_codes,
          sign: JSON.parse(sign),
        }
        respond_with JSON.generate(response)
      end

      private

      def time
        Display.last.time * 1000
      end

      def show_device_codes
        Display.last.show_device_codes
      end

    end
  end
end
