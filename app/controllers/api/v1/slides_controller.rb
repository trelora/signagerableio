module Api
  module V1
    class SlidesController < ApiController
      respond_to :json

      def create
        slide = Slide.new(slide_params)
        if slide.confirm_save
          render json: {'redirect': true,
                        'redirect_url': admin_slides_path}
        else
          render json: {'redirect': false,
                        'error': 'slide did not save'}
        end
      end

      private
      def slide_params
        params.require(:slide).permit(
          :title,
          :subtitle,
          :ribbon_display,
          :ribbon,
          :ribbon_color,
          :custom_background,
          :display_rate,
          :active
        )
      end
    end
  end
end
