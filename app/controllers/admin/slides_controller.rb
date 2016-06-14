class Admin::SlidesController < ApplicationController
  def update
    Slide.update_slides
    redirect_to admin_devices_path
  end
end
