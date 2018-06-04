every 6.hours do
  rake "daily:fetch_price"
end

every 12.hours do
  rake "daily:generate_report"
end
