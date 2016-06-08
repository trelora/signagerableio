class Admin::DevicesController < ApplicationController
  def index
    @devices = Device.all
  end
end
