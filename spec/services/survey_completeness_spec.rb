require 'rails_helper'

RSpec.describe SurveyCompleteness do

  describe '#initialize' do
    before :context do
      SurveyResponse.destroy_all
      Election.destroy_all
      2.times { create :survey_response_ss_with_values }
      2.times { create :survey_response_sal_with_values }
      2.times { create :tech_software }
      2.times { create :tech_machine }
    end

    it 'sets type and relation', focus: true do
      expect(SurveyResponse.limit(2).size).to eq(2)
      sr_relation   = SurveyCompleteness.new(SurveyResponse.limit(2))
      sr_record     = SurveyCompleteness.new(SurveyResponse.first)
      tech_relation = SurveyCompleteness.new(TechVotingSoftware.limit(2))
      tech_record   = SurveyCompleteness.new(TechVotingMachine.first)

      expect(sr_relation.relation).to be(true)
      expect(sr_relation.type).to eq(:sr)

      expect(sr_record.relation).to be(false)
      expect(sr_record.type).to eq(:sr)

      expect(tech_relation.relation).to be(true)
      expect(tech_relation.type).to eq(:tech)

      expect(tech_record.relation).to be(false)
      expect(tech_record.type).to eq(:tech)
    end
  end

end