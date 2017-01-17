class Admin::SlidesController < ApplicationController
  layout "admin"
  before_action :authorize!

  def refresh
    Slide.update_slides
    Role.update_roles
    redirect_to admin_devices_path
  end

  def index
    @custom_slides = Slide.where(custom: true).order(:created_at)
  end

  def new
  end

  def edit
    @slide = Slide.find_by(id: params[:id])
  end

  def destroy
    slide = Slide.find(params[:id])
    slide.destroy
    flash[:success] = 'Custom Slide Successfully Deleted'
    redirect_to admin_slides_path
  end

  private
  def slide_params
    params.require(:slide).permit(
      :title,
      :subtitle,
      :display_rate,
      :active,
      :ribbon_display,
      :ribbon,
      :ribbon_color,
      :custom_background
    )
  end

  def confirm_update(params)
    slide = Slide.find(params[:id])
    if slide.update_preview?
      slide.confirm_save
    else
      params = slide_params
      params.merge!(role: "confirm#{slide.determine_role}")
      slide.update(params)
    end
  end
end
