require 'rails_helper'

RSpec.describe ResponsePersistor do
  context 'saving a new survey' do
    before(:each) {
      @response = ElectionProfile.new(county_id: 59, election_year_profile_id: ElectionYearProfile.last.id)
      @sr_count = SurveyResponse.count
    }
    after(:each) {
      @response.destroy
    }

    it "creates a new SurveyResponse record" do
      ResponsePersistor.new(@response).save
      expect(SurveyResponse.count).to be(@sr_count + 1)
    end
  end
end