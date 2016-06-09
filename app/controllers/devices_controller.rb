class DevicesController < ApplicationController
  def create
    if cookies[:device_code].nil?
      device = Device.new
      cookies.permanent[:device_code] = device.generate_device_code
    end
    redirect_to device_path(0)
  end

  def show
    @device = Device.find_by(device_code: cookies[:device_code])
    @device.update(last_visit: Time.now.to_s)
  end
end
