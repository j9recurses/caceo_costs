require "rails_helper"

RSpec.describe DailyActivitiesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/daily_activities").to route_to("daily_activities#index")
    end

    it "routes to #new" do
      expect(:get => "/daily_activities/new").to route_to("daily_activities#new")
    end

    it "routes to #show" do
      expect(:get => "/daily_activities/1").to route_to("daily_activities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/daily_activities/1/edit").to route_to("daily_activities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/daily_activities").to route_to("daily_activities#create")
    end

    it "routes to #update" do
      expect(:put => "/daily_activities/1").to route_to("daily_activities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/daily_activities/1").to route_to("daily_activities#destroy", :id => "1")
    end

  end
end
