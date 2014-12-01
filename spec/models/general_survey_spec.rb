require 'rails_helper'

RSpec.describe GeneralSurvey  do
  let(:ssbal) { Ssbal.new(ssbalpriprou: 0.23, ssballayout: 1000, ssbaltransl: 25) }
  let(:survey) { GeneralSurvey.new(ssbal) }
  subject { survey }

  describe 'survey type' do
    it 'correctly returns true for services' do
      expect(election_profile?).to be false
      expect(service_supply?).to be true
      expect(salary).to be false
    end
  end
end