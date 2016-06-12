require 'rails_helper'

RSpec.describe TreloraServices do
  let(:service) { TreloraServices.new }

  it "returns houses listed as 'sold'" do
    VCR.use_cassette "#house_listing('sold')" do
      trelora      = service.house_listing('sold')
      first_result = trelora.first

      expect(trelora.count).to eq(33)
      expect(first_result[:role]).to eq("Sold")
      expect(first_result[:ribbon]).to eq("Sold!")
      expect(first_result[:ribbon_color]).to eq("#428bca")
      expect(first_result[:title]).to eq("Congratulations Roger!")
      expect(first_result[:subtitle]).to eq("1000 Yampa St 201,  Aurora, 80017")
      expect(first_result[:best_large_image]).to eq("http://trelora.smugmug.com/1000-S-Yampa-201/i-CF77gQx/0/X2/IMG_5477_8_9-X2.jpg")
      expect(first_result[:images].count).to eq(28)
    end
  end

  it "returns houses listed as 'coming soon'" do
    VCR.use_cassette "#house_listing('comingsoon')" do
      trelora      = service.house_listing('comingsoon')
      first_result = trelora.first

      expect(trelora.count).to eq(21)
      expect(first_result[:role]).to eq("Coming Soon")
      expect(first_result[:ribbon]).to eq("Coming Soon!")
      expect(first_result[:ribbon_color]).to eq("#99cc77")
      expect(first_result[:title]).to eq("1499 Blake St Unit 3L,  Denver, 80202")
      expect(first_result[:subtitle]).to eq("Ask for more information")
      expect(first_result[:best_large_image]).to eq("https://trelora.smugmug.com/1499-Blake-St-Unit-3L/i-pmXPcMm/0/X2/IS1fovc14evo0k0000000000-X2.jpg")
      expect(first_result[:images].count).to eq(29)
    end
  end
end
