class Admin::SlidesController < ApplicationController
  def refresh
    Slide.update_slides
    Role.update_roles
    redirect_to admin_devices_path
  end

  def index
  end

  def show
  end

  def new
    @slide = Slide.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
