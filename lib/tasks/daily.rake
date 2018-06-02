namespace :daily do
  desc "Fetch price rake"
  task fetch_price: :environment do
    FetchPriceJob.new.perform
  end

  desc "Generate Sanity check report"
  task generate_report: :environment do
    DataQualityJob.new.perform
  end
end
