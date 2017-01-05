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
      flash.now[:error] = 'You must enter at least a title or a custom background to preview this slide'
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def slide_params
    params.require(:slide).permit(:title, :subtitle, :display_rate, :active, :ribbon_display)
  end
end
