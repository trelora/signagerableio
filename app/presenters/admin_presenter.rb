class AdminPresenter

  def all
    Device.all
  end

  def display
    Display.find(1)
  end

  def time
    display.time
  end
end
