require 'rails_helper'

RSpec.describe "daily_activities/index", :type => :view do
  before(:each) do
    assign(:daily_activities, [
      DailyActivity.create!(),
      DailyActivity.create!()
    ])
  end

  it "renders a list of daily_activities" do
    render
  end
end
