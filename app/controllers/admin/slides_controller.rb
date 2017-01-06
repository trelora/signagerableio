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

  def show
    @slide = Slide.find_by(id: params[:id])
  end

  def new
    @slide = Slide.new
  end

  def create
    if params[:commit] == 'Save Slide' && @slide = Slide.create_preview(slide_params)
      @slide.confirm_save
      flash[:success] = 'Custom Slide Successfully Saved'
      redirect_to admin_devices_path
    elsif @slide = Slide.create_preview(slide_params)
      redirect_to admin_slide_path(@slide)
    else
      flash[:danger] = 'You must enter at least a title or a custom background to preview this slide'
      redirect_to new_admin_slide_path
    end
  end

  def confirm
    slide = Slide.find(params[:slide_id])
    slide.confirm_save
    flash[:success] = 'Custom Slide Successfully Saved'
    redirect_to admin_devices_path
  end

  def edit
    @slide = Slide.find_by(id: params[:id])
  end

  def update
    if params[:commit] == 'Save Slide'
      confirm_update(params)
      redirect_to admin_devices_path
    else
      slide = Slide.find(params[:id])
      if slide.update_preview? || slide.role == 'pending'
        slide.update(slide_params)
        redirect_to admin_slide_path(slide)
      elsif preview_slide = Slide.create_preview(slide_params, slide.id)
        redirect_to admin_slide_path(preview_slide)
      else
        flash[:danger] = 'You must enter at least a title or a custom background to preview this slide'
        redirect_to edit_admin_slide_path(slide)
      end
    end
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
      slide.update(slide_params)
    end
  end
end
