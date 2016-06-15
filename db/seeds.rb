class Seed
  def initialize
    Display.create(time: 1)
    User.create(email: "admin@trelora.com", password: "password")
  end
end

Seed.new
