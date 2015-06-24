require 'rails_helper'

RSpec.describe SurveyResponseForm do
  let(:survey_response) { build :survey_response }
  let(:response)        { build :response }
  let(:sr_form) {
    SurveyResponseForm.include(ResponseForm.build('Ssveh')).new( survey_response )
  }
  let(:saved_sr)        { create :survey_response }
  let(:sr_with_values)  { build :survey_response_with_values }
  let(:sr_form_responded) {
    SurveyResponseForm.survey('Ssveh').new(sr_with_values)
  }
  let(:saved_sr_responded) do
    sr_form_responded.submit
    SurveyResponse.find(sr_form_responded.model.id)
  end
  let(:int_qs) { survey_response.questions.where(data_type: 'integer') }

  context '#submit' do
    it 'initializes values' do
      sr_form.submit
      qs = survey_response.questions.count
      expect(ResponseValue.where(survey_response: survey_response).count).to eq qs
      expect(survey_response.values.count).to eq qs
    end

    it 'creates correct integer_value' do
      q = int_qs.first
      sr_form.response.send("#{int_qs[0].field}=", 6667)
      sr_form.submit
      expect(ResponseValue.where(survey_response: survey_response, question: q).size).to be 1
      expect(ResponseValue.find_by(survey_response: survey_response, question: q).integer_value).to eq 6667
    end

    it 'raises error without an associated response' do
      sr_form.response = nil
      expect { sr_form.submit }.to raise_error('No Response')
    end

    describe 'filled in manually' do
      it 'persists' do
        ssveh_hash = { county_id: 4, election_id: 6, 
          response: { ssvehrent: 120, ssvehfuel: 123} }
        expect(sr_form.validate(ssveh_hash)).to be true
        expect(sr_form.response.valid?).to be true
        expect(sr_form.submit).to be true
      end
    end
  end

  describe 'updating' do
    it 'updates value' do
      expect(saved_sr_responded.values.pluck(:integer_value).compact.length)
        .to eq 3
      expect(ResponseValue.find_by(
        survey_response: saved_sr_responded, question: int_qs.find_by(field: :ssvehrent))
        .integer_value).to eq 20
    end

    it 'updates updated_at only on altered field' do
      srf = SurveyResponseForm.include(ResponseForm.build(Ssveh)).new(
        SurveyResponse.find(saved_sr_responded.id))

      srf.response.ssvehins = 55
      srf.submit
      sr = SurveyResponse.find(saved_sr_responded.id)
      expect(sr.values.pluck(:integer_value).compact.length).to eq 4
      expect(ResponseValue.find_by(survey_response: sr, question:
        Question.find_by(field: 'ssvehins')).integer_value).to eq 55
      expect(ResponseValue.find_by(survey_response: sr, question: 
        Question.find_by(field: 'ssvehcount' )).integer_value).to eq 165
    end
  end

  context "N/A" do
    describe 'empty as N/A action' do
      it 'sets _na to true on empty' do
        sr_form.empty_na.submit
        na_able_qids = sr_form.model.questions.where(na_able: true).pluck(:id)
        sr = SurveyResponse.find(sr_form.model.id)
        expect(sr.values.where(na_value: true).count).to eq(
          sr.values.where(question_id: na_able_qids).count)
      end

      it 'only affects empties' do
        sr_form_responded.empty_na.submit
        sr = SurveyResponse.find(sr_form_responded.model.id)
        filled_ids = [int_qs[0].id, int_qs[1].id]
        expect(sr.values.where(na_value: true).count).to eq 1
        expect(sr.values.where(na_value: true, question_id: filled_ids).count)
          .to eq 0
      end
    end
  end
end