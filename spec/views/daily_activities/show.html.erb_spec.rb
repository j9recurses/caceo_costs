require 'rails_helper'

RSpec.describe "daily_activities/show", :type => :view do
  before(:each) do
    @daily_activity = assign(:daily_activity, DailyActivity.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
