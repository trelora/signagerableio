class DevicesController < ApplicationController
  def create
    if cookies[:device_code].nil? || Device.find_by(device_code: cookies[:device_code]).blank?
      device = Device.new
      cookies.permanent[:device_code] = device.generate_device_code
    end
    redirect_to device_path(0)
  end

  def show
    @device = Device.find_by(device_code: cookies[:device_code])
    if @device.present?
      @device.seen!
    else
      redirect_to '/'
    end
  end
end
