class Admin::DevicesController < ApplicationController
  layout "admin"
  before_action :authorize!

  def index
    @devices = AdminPresenter.new
    @active_custom_slides = Slide.where(custom: true, active: true)
  end

  def edit
    @device = Device.find_by(id: params[:id])
  end

  def update
    device = Device.find(params[:id])
    if device.update(device_params)
      redirect_to admin_devices_path
    else
      render edit_admin_device_path(params[:id])
    end
  end

  def destroy
    Device.find(params[:id]).delete
    redirect_to admin_devices_path
  end

  def reveal
    Display.last.update_column(:show_device_codes, !Display.last.show_device_codes)
    redirect_to admin_devices_path
  end

  private
  def device_params
    params.require(:device).permit(:device_code, :nickname, :role)
  end
end
