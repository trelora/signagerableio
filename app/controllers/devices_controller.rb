class DevicesController < ApplicationController
  def create
    if cookies[:device_code].nil?
      device = Device.new
      cookies[:device_code] = device.generate_device_code
    end
    redirect_to device_path(0)
  end

  def show
    @device = Device.find_by(device_code: cookies[:device_code])
  end
end
