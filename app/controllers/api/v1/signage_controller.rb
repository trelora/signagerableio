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
          cookies.permanent[:counter] ||= 1
        end

        role = device.role
        sign = (Slide.display_custom_on_rotation(cookies[:counter]) ||
                Slide.where('api_role = ?', role).order("RANDOM()").first).to_json
        cookies.permanent[:counter] = Slide.update_counter(cookies[:counter].to_i) || 1

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
