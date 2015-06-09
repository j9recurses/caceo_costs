require 'rails_helper'

RSpec.describe ResponseValue, type: :model do
  # let(:response) { Ssveh.new(county_id: 59, election_year_id: 18) }
  let(:survey_response) do 
    r = Ssveh.new(county_id: 59, election_year_id: 18)
    sr = SurveyResponse.new( response: r, county_id: 59, election_id: 18 )
    sr.response.survey_response = sr
    sr
  end

  context 'single transaction' do
    it 'initializes values on survey_response save' do
      survey_response.save
      expect(survey_response.values.count).to eq(survey_response.questions.count)
      expect(ResponseValue.where(survey_response: survey_response)).to be_truthy
    end
    describe '#sync_survey_response_question' do
      it 'creates a value' do
        survey_response.save

        q = survey_response.questions.where(data_type: 'integer').first
        survey_response.respond(q, 6667)
        ResponseValue.sync_survey_response_question(survey_response, q)
        expect(ResponseValue.where(survey_response: survey_response, question: q).size).to be 1
      end
    end
  end

  describe 'updating values' do
    let(:saved_sr) { survey_response.save; SurveyResponse.find(survey_response.id) }
    let(:int_questions) { survey_response.questions.where(data_type: 'integer') }

    it 'sanity check, values created' do
      expect(saved_sr.values.count).to eq saved_sr.questions.count
    end

    it 'updates value' do
      q = int_questions.first
      saved_sr.response.send(q.field + '=', 6666)
      saved_sr.save
      expect(saved_sr.values.group(:integer_value).length).to eq 2
      expect(ResponseValue.find_by(survey_response: saved_sr, question: q).integer_value).to eq 6666
    end

    it 'updates updated_at only on altered field' do
      saved_sr.respond(int_questions[0], 6666)
      saved_sr.respond(int_questions[1], 12)
      saved_sr.save
      expect(saved_sr.values.group(:integer_value).length).to eq 3
      expect(ResponseValue.find_by(survey_response: saved_sr, question: int_questions[1]).integer_value).to eq 12
    end
  end
end
