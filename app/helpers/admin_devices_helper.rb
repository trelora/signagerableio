module AdminDevicesHelper
  def formatted_time(time)
    if time.nil?
      ""
    else
      Time.parse(time).strftime("%A, %d %b %Y %l:%M %p")
    end
  end
end
