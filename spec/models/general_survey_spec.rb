require 'rails_helper'

RSpec.describe GeneralSurvey  do
  let(:ssbal) { Ssbal.new(ssbalpriprou: 0.23, ssballayout: 1000, ssbaltransl: 25) }
  let(:survey) { GeneralSurvey.new(ssbal) }
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
      expect(survey.service_supply_total).to be 1025
    end
  end

  # describe 'election' do 
  #   it 'returns an ElectionYear' do
  #     expect( survey.election.class ).to be ElectionYear
  #   end
  # end
end