require 'rails_helper'

RSpec.describe GeneralSurvey  do
  let(:response) { create :ss_response_with_values }
  let(:survey) { GeneralSurvey.new(response) }
  subject { survey }

  describe 'survey type' do
    it 'correctly returns true for services' do
      expect(survey.election_profile?).to be false
      expect(survey.service_supply?).to be true
      expect(survey.salary?).to be false
    end
  end

  describe 'survey_total' do
    it 'has the right policy for service_supply' do
      expect(survey.service_supply_total).to eq 320
    end
  end

  # describe 'election' do 
  #   it 'returns an ElectionYear' do
  #     expect( survey.election.class ).to be ElectionYear
  #   end
  # end
end