require 'rails_helper'

RSpec.describe Subsection do
  let(:survey) { Survey.find('Salbal') }
  let(:survey_subsection) { survey.subsections.first }
  context 'with no survey' do
    let(:subsection) { Subsection.new }

    it 'responds to #survey_totals' do
      expect(subsection).to respond_to(:survey_totals)
    end

    it 'responds to #surveys' do
      expect(subsection).to respond_to(:surveys)
    end
  end

  describe '#questions_for survey' do
    let(:subsection_qs) { survey_subsection.questions_for(survey) }
    it 'returns relation with questions' do
      expect(subsection_qs.is_a? ActiveRecord::Relation).to be true
      expect(subsection_qs.class).to be Question::ActiveRecord_Relation
    end

    it 'contains the correct questions' do
      survey_qs = survey.questions.where(subsection_id: survey_subsection.id)
      expect(survey_qs.count).to eq subsection_qs.count
      expect(survey_qs).to eq subsection_qs
    end
  end
end