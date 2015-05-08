require 'rails_helper'

RSpec.describe ResponseValue, type: :model do


  context 'single transaction' do
    before(:each) do
      @response = Ssveh.new(county_id: 59, election_year_id: 18)
      @survey_response = SurveyResponse.new( response: @response, county_id: 59, election_id: 18 )
      @response.survey_response = @survey_response
    end
    after(:each) do
      @survey_response.destroy
    end

    it 'initializes values on survey_response save' do
      @survey_response.save
      expect(@survey_response.values.count).to eq(@survey_response.questions.count)
      expect(ResponseValue.where(survey_response: @survey_response)).to be_truthy
    end

    describe '#sync_survey_response_question' do
      it 'creates a value' do
        @survey_response.save

        q = @survey_response.questions.where(data_type: 'integer').first
        @survey_response.respond(q, 6667)
        ResponseValue.sync_survey_response_question(@survey_response, q)
        expect(ResponseValue.where(survey_response: @survey_response, question: q).size).to be 1
      end
    end
  end

  describe 'updating values' do
    before(:context) do
      @response = Ssveh.new(county_id: 59, election_year_id: 18)
      @survey_response = SurveyResponse.new( response: @response, county_id: 59, election_id: 18 )
      @response.survey_response = @survey_response
      @survey_response.save
      @int_questions = @survey_response.questions.where(data_type: 'integer')

    end
    after(:context) do
      @survey_response.destroy
    end

    it 'sanity check, values created' do
      expect(@survey_response.values.count).to eq @survey_response.questions.count
    end

    it 'updates value' do
      q = @int_questions.first
      @survey_response.response.send(q.field + '=', 6666)
      @survey_response.save
      expect(@survey_response.values.group(:integer_value).length).to eq 2
      expect(ResponseValue.find_by(survey_response: @survey_response, question: q).integer_value).to eq 6666
    end

    it 'updates updated_at only on altered field' do
      @survey_response.respond(@int_questions[1], 12)
      @survey_response.save
      expect(@survey_response.values.group(:integer_value).length).to eq 3
      expect(ResponseValue.find_by(survey_response: @survey_response, question: @int_questions[1]).integer_value).to eq 12
    end
  end
end
