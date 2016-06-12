class Admin::DevicesController < ApplicationController
  layout "admin"

  def index
    @devices = AdminPresenter.new
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

  private
  def device_params
    params.require(:device).permit(:device_code, :nickname, :role)
  end
end
