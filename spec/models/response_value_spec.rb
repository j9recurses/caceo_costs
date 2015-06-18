require 'rails_helper'

RSpec.describe ResponseValue, type: :model do
  let(:survey_response) do 
    r = Ssveh.new(county_id: 59, election_year_id: 18)
    sr = SurveyResponse.new( response: r, county_id: 59, election_id: 18 )
    sr.response.survey_response = sr
    sr
  end
  let(:int_questions) { survey_response.questions.where(data_type: 'integer') }
  let(:sr_with_values) {
    survey_response.respond(int_questions[0], 6666)
    survey_response.respond(int_questions[1], 12)
    survey_response
  }
  let(:sr_form) { SurveyResponseForm.survey('Ssveh').new( survey_response ) }
  let(:sr_form_with_values) { SurveyResponseForm.survey('Ssveh').new( sr_with_values ) }
  let(:saved_sr) { sr_form.submit; SurveyResponse.find(survey_response.id) }

  describe 'totaling' do
    it 'adds up' do
      sr_form_with_values.submit
      expect(sr_form_with_values.model.values.total).to eq(6666 + 12)
    end

    it 'adds up after changes' do
      expect(sr_form_with_values.submit).to be true
      srf = SurveyResponseForm.survey(Ssveh).new(SurveyResponse.find(sr_with_values.id))
      srf.response.send("#{int_questions[0].field}=", 20)
      srf.submit
      expect(srf.persisted?).to be true
      expect(srf.model.values.total).to eq(20 + 12)
    end
  end
end
