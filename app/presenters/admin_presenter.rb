class AdminPresenter

  def all
    Device.all
  end

  def display
    Display.last
  end

  def time
    display.time
  end
end
