require 'rails_helper'

RSpec.describe ResponsePersistor do
  context 'submitting a new survey' do
    before(:each) {
      @response = ElectionProfile.new(county_id: 59, election_year_id: ElectionYear.last.id )
      @sr_count = SurveyResponse.count
    }
    after(:each) {
      @response.destroy
    }

    it "creates a new SurveyResponse record" do
      expect(@response.valid?).to be(true)
      puts @response.errors
      ResponsePersistor.new(@response).submit
      expect(@response.persisted?).to be(true)
    end
  end
end