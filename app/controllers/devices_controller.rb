class DevicesController < ApplicationController
  def create
    if cookies[:device_code].nil? || Device.find_by(device_code: cookies[:device_code]).blank?
      device = create_device
    end
    redirect_to device_path(0)
  end

  def show
    @device = Device.find_by(device_code: cookies[:device_code])
    if @device.present?
      @device.seen!
    else
      @device = create_device
    end
  end
end
