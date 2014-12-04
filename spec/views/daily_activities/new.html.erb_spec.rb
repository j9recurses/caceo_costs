require 'rails_helper'

RSpec.describe "daily_activities/new", :type => :view do
  before(:each) do
    assign(:daily_activity, DailyActivity.new())
  end

  it "renders new daily_activity form" do
    render

    assert_select "form[action=?][method=?]", daily_activities_path, "post" do
    end
  end
end
