class Admin::DisplayController < ApplicationController
  layout "admin"
  def update
    Display.find(params[:id]).update(display_params)
    redirect_to admin_devices_path
  end

  private
  def display_params
    params.require(:display).permit(:time)
  end
end
