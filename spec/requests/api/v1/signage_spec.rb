require "rails_helper"

RSpec.describe "GET /api/v1/signage" do
  it "returns an array of signage hashes" do
    VCR.use_cassette "internal_api" do
      get '/'
      device = Device.last
      device.update(role: "comingsoon")

      get "/api/v1/signage"

      expect(json_body.first["best_large_image"]).to eq("https://trelora.smugmug.com/1499-Blake-St-Unit-3L/i-pmXPcMm/0/X2/IS1fovc14evo0k0000000000-X2.jpg")
      expect(json_body.first["ribbon"]).to eq("Coming Soon!")
      expect(json_body.first["ribbon_color"]).to eq("#99cc77")
      expect(json_body.first["role"]).to eq("Coming Soon")
      expect(json_body.first["splash"]).to eq(nil)
      expect(json_body.first["subtitle"]).to eq("Ask for more information")
      expect(json_body.first["title"]).to eq("1499 Blake St Unit 3L,  Denver, 80202")
    end
  end
end
