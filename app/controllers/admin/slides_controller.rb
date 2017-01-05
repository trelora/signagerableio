class Admin::SlidesController < ApplicationController
  layout "admin"
  before_action :authorize!

  def refresh
    Slide.update_slides
    Role.update_roles
    redirect_to admin_devices_path
  end

  def index
  end

  def show
    @slide = Slide.find_by(id: params[:id])
  end

  def new
    @slide = Slide.new
  end

  def create
    if @slide = Slide.create_preview(slide_params)
      redirect_to admin_slide_path(@slide)
    else
      flash[:danger] = 'You must enter at least a title or a custom background to preview this slide'
      redirect_to new_admin_slide_path
    end
  end

  def confirm
    slide = Slide.find_by(id: params[:slide_id])
    slide.confirm_save
    flash[:success] = 'Custom Slide Successfully Saved'
    redirect_to admin_devices_path
  end

  def edit
  end

  def update
  end

  def destroy
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
end
