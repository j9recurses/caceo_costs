require 'rails_helper'

RSpec.describe SurveyResponse do
  describe "associations" do
    context "on new record" do
      before(:context) {
        @survey_response = SurveyResponse.new
        @election_profile = ElectionProfile.create!(county_id: 59, election_year_profile_id: ElectionYearProfile.last.id)
        @salbal = Salbal.create!(county_id: 59, election_year_id: ElectionYear.last.id)
      }

      after(:context) {
        @election_profile.destroy
        @salbal.destroy
      }

      it "allows county=" do
        @survey_response.county = County.last
        expect(@survey_response.county_id).to eq(County.last.id)
      end

      it "allows survey=" do
        @survey_response.survey = Survey.last
        expect(@survey_response.survey_id).to eq(Survey.last.id)
      end      

      it "allows election=" do
        @survey_response.election = ElectionYear.last
        expect(@survey_response.election_id).to eq(ElectionYear.last.id)
      end      

      it "allows response=" do
        @survey_response.response = @election_profile
        expect(@survey_response.response_id).to eq(@election_profile.id)
        expect(@survey_response.response_type).to eq("ElectionProfile")
      end

      it "updates response" do
        expect(@survey_response.response_type).to eq("ElectionProfile")
        @survey_response.response = @salbal

        expect(@survey_response.response_type).to eq("Salbal")
      end

      context "saving" do
        before(:each) {
          @valid_sr = SurveyResponse.new(@survey_response.attributes)
        }

        it 'requires election' do
          @valid_sr.election = nil
          expect { @valid_sr.save }.to raise_error
        end        

        it 'requires survey' do
          @valid_sr.survey = nil
          expect { @valid_sr.save }.to raise_error
        end        

        it 'requires response' do
          @valid_sr.response = nil
          expect { @valid_sr.save }.to raise_error
        end        

        it 'requires county' do
          @valid_sr.county = nil
          expect { @valid_sr.save }.to raise_error
        end
      end
    end
  end
end