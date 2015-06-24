require 'rails_helper'

RSpec.describe ResponseValue, type: :model do
  let(:survey_response) do
     sr = FactoryGirl.create(:survey_response_with_values)
     ResponseValue.sync_survey_response sr
     sr
  end
  let(:empty_sr) { create :survey_response }

  describe '::total' do
    it 'adds up' do
      expect(survey_response.values.total).to eq(135+20+165)
    end
    it 'adds up after changes' do
      survey_response.respond(Question.find_by(field: :ssvehrent), 100)
      survey_response.save!
      ResponseValue.sync_survey_response survey_response
      expect(survey_response.values.total).to eq(135+100+165)      
    end
  end

  describe '::answered & #answered?' do
    it 'count questions with values' do
      answer_count = survey_response.values.inject(0) { |memo, val|
        val.answered? ? memo + 1 : memo
      }
      expect(answer_count).to eq 3
      expect(survey_response.values.answered).to eq 3
    end

    it 'no false positives' do
      answer_count = empty_sr.values.inject(0) { |memo, val|
        val.answered? ? memo + 1 : memo
      }
      expect(answer_count).to eq 0
      expect(empty_sr.values.answered).to eq 0
    end

    describe '::answered_ratio' do
      it 'works with 0/0' do
        expect(empty_sr.values.answered_ratio).to eq 0.0
      end

      it 'works' do
        expect(survey_response.values.answered_ratio).to eq 0.6
      end
    end

    describe '::percent_answered' do
      it 'returns 0' do
        perc = empty_sr.values.percent_answered
        expect(perc).to eq 0
        expect(perc.is_a? Integer).to be true
      end

      it 'returns an integer' do
        perc = survey_response.values.percent_answered
        expect(perc).to eq 60
        expect(perc.is_a? Integer).to be true
      end
    end
  end

  describe '#value' do
    it 'returns an integer for an int question' do
      expect(survey_response.values.first.value.is_a? Integer).to be true
    end

    it 'returns the correct value' do
      q = survey_response.questions.find_by(field: :ssvehrent)
      v = survey_response.values.find_by(question: q)
      expect(v.value).to eq 20
    end

    it 'returns "N/A" for no_value == true' do
      v = survey_response.values.first
      v.na_value = true
      v.save!
      expect(v.value).to eq('N/A')
    end
  end
end
