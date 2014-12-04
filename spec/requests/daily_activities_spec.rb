require 'rails_helper'

RSpec.describe "DailyActivities", :type => :request do
  describe "GET /daily_activities" do
    it "works! (now write some real specs)" do
      get daily_activities_path
      expect(response).to have_http_status(200)
    end
  end
end
