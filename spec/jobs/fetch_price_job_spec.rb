require 'rails_helper'
describe "FetchPriceJob" do
  context "when price data is not available" do
    let!(:market) { create(:market) }
    it "does not create price data" do
      expect(BittrexService).to receive(:fetch_market_prices!).and_return(
        {
          "result" => [
            {"O"=>0.01566525, "H"=>0.01566525, "L"=>0.01566525, "C"=>0.01566525, "V"=>0.05604449, "T"=>"2018-05-23T18:04:00", "BV"=>0.00087795}
          ]
        }
      )
      FetchPriceJob.new.perform
      expect(MarketPrice.count).to eql(1)
    end
  end
end
