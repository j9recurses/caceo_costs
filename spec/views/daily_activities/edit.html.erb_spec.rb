require 'rails_helper'

RSpec.describe "daily_activities/edit", :type => :view do
  before(:each) do
    @daily_activity = assign(:daily_activity, DailyActivity.create!())
  end

  it "renders the edit daily_activity form" do
    render

    assert_select "form[action=?][method=?]", daily_activity_path(@daily_activity), "post" do
    end
  end
end
