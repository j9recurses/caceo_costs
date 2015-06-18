require 'rails_helper'

RSpec.describe SurveyResponse do
  describe "totaling" do
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

    let(:saved_sr_with_values) { sr_form_with_values.submit; SurveyResponse.find(sr_with_values.id) }

    let(:second_saved_sr_with_values) do
      r = Ssveh.new(county_id: 59, election_year_id: 19)
      sr = SurveyResponse.new(response: r, county_id: 59, election_id: 19)
      sr.respond(int_questions[2], 100)
      sr.respond(int_questions[1], 900)
      srf = SurveyResponseForm.survey(Ssveh).new(sr)
      srf.submit 
      SurveyResponse.find sr.id
    end


    it 'adds up multiple survey_responses' do
      expect(SurveyResponse.total(saved_sr_with_values, second_saved_sr_with_values)).to eq(7678)
    end
  end

  describe "associations" do
    context "on new record" do
      let(:survey_response) { SurveyResponse.new }
      let(:election_profile) { ElectionProfile.new(county_id: 59, election_year_id: ElectionYear.last.id) }
      let(:salbal) { Salbal.new(county_id: 59, election_year_id: ElectionYear.last.id) }

      it "allows county=" do
        survey_response.county = County.last
        expect(survey_response.county_id).to eq(County.last.id)
      end

      it "allows survey=" do
        survey_response.survey = Survey.last
        expect(survey_response.survey).to eq(Survey.last)
      end      

      it "allows election=" do
        survey_response.election = ElectionYear.last
        expect(survey_response.election_id).to eq(ElectionYear.last.id)
      end

      it "allows response=" do
        survey_response.response = election_profile
        expect(survey_response.response_id).to eq(election_profile.id)
        expect(survey_response.response_type).to eq("ElectionProfile")
      end

      it "updates response" do
        survey_response.response = election_profile
        expect(survey_response.response_type).to eq("ElectionProfile")
        survey_response.response = salbal
        expect(survey_response.response_type).to eq("Salbal")
      end

      context "saving" do
        # they raise errors because these fields are NOT NULL
        # with validations they won't
        let(:valid_sr) { SurveyResponse.new(survey_response.attributes) }
        
        it 'requires election' do
          valid_sr.election = nil
          expect { valid_sr.save! }.to raise_error
          # expect( valid_sr.save ).to be true
        end        

        it 'requires survey' do
          valid_sr.survey = nil
          expect { valid_sr.save! }.to raise_error
        end        

        it 'requires response' do
          valid_sr.response = nil
          expect { valid_sr.save! }.to raise_error
        end        

        it 'requires county' do
          valid_sr.county = nil
          expect( valid_sr.valid? ).to be false
        end

        it 'requires county_id' do
          valid_sr.county_id = nil
          # puts valid_sr.inspect
          expect( valid_sr.valid? ).to be false
        end
      end

      context 'response convenience method' do
        let(:sr_ep) { survey_response.response = election_profile; survey_response }
        let(:question) { survey_response.questions.where(data_type: 'integer').first }

        it '#respond sets response value' do
          sr_ep.respond(question, 1245)
          expect(election_profile.send(question.field)).to eq 1245
        end

        it '#respond updates value' do
          sr_ep.respond(question, 5421)
          expect(election_profile.send(question.field)).to eq 5421
        end
      end
    end
  end
end