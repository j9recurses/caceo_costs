json.array!(@daily_activities) do |daily_activity|
  json.extract! daily_activity, :id
  json.url daily_activity_url(daily_activity, format: :json)
end
