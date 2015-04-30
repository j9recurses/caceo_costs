require 'rails_helper'

RSpec.describe SurveyResponseValue, type: :model do
  let(:survey_response) { SurveyResponse.new( response: Salbal.new, county_id: 59, election_id: 18 ) }

  describe 'trigger' do
    it 'initializes values on survey_response save' do
      survey_response.save
      expect(survey_response.values.count).to eq(survey_response.questions.count)
    end
  end
end
