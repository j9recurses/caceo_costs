require 'rails_helper'

RSpec.describe SurveyResponse do
  let(:saved_sr_with_values)     { create :survey_response_sal_with_values }
  let(:saved_ss_sr_with_values)  { create :survey_response_ss_with_values }
  let(:election) { create :election }

  describe 'total internals' do
    let(:policy_subsections) { Subsection.where(
      title: ['Salaries - Types of Staff and Pay', 'Benefits - in Dollars'])
    }

    describe '#total_relation with salbal (salary total policy)' do
      it 'returns ids from benefits_dollars and salary_types' do
        q_ids = Question.where(subsection: policy_subsections, survey_id: 'Salbal').pluck(:id)
        rv_ids = ResponseValue.where(question_id: q_ids, survey_response_id: saved_sr_with_values.id).pluck(:id)

        expect(saved_sr_with_values.total_relation.pluck(:id).sort).to eq(rv_ids.sort)
      end
    end

    describe '::total_relation with salbal (salary total policy)' do
      it 'returns ids from benefits_dollars and salary_types' do
        sr1 = FactoryGirl.create :survey_response_sal_with_values
        sr2 = FactoryGirl.create :survey_response_sal_with_values
        sr3 = FactoryGirl.create :survey_response_sal_with_values
        sr_ids = [sr1.id, sr2.id, sr3.id]

        q_ids = Question.where(subsection: policy_subsections, survey_id: 'Salbal').pluck(:id)
        rv_ids = ResponseValue.where(question_id: q_ids, survey_response_id: sr_ids).pluck(:id)

        expect(SurveyResponse.where(id: sr_ids).total_relation.pluck(:id).sort).to eq(rv_ids.sort)
      end
    end

    describe '::value_ids' do
      # NO TIME TODAY, BUT DO NOT CONSIDER STABLE
    end
  end

  describe "totaling" do
    let(:int_questions) { Question.where(data_type: 'integer', survey_id: Ssveh) }
    let(:second_saved_sr_with_values) do
      c = FactoryGirl.create(:county)
      r = Ssveh.new(county: c, election_year_id: election.id)
      sr = SurveyResponse.new(response: r, county_id: c.id, election: election)
      sr.respond(int_questions[2], 100)
      sr.respond(int_questions[1], 900)
      srf = SurveyResponseForm.new(sr)
      srf.submit 
      SurveyResponse.find sr.id
    end

    # Unless we switch to a clean db, this can be easily corrupted
    it 'adds up multiple survey_responses' do
      # ResponseValue.sync_survey_response 
      saved_sr_with_values
      second_saved_sr_with_values
      expect(SurveyResponse.all.total).to eq(1000)
      expect(SurveyResponse.all.total(:inverse)).to eq(1320)
    end

    it 'adds up single record total' do
      expect(saved_sr_with_values.total).to eq(0)
      expect(saved_sr_with_values.total(:inverse)).to eq(320)

      tp_q = Subsection.find_by(title: 'Salaries - Types of Staff and Pay').questions.first
      saved_sr_with_values.respond(tp_q, 9876)
      saved_sr_with_values.save!
      ResponseValue.sync_survey_response saved_sr_with_values
      expect(saved_sr_with_values.total).to eq(9876)
    end

  end

  describe "#values_in_subsection" do
    describe 'with no subsections' do
      it 'returns empty relation' do
        vs = saved_ss_sr_with_values.values_in_subsection(Subsection.first)
        expect( vs.count ).to eq 0
        expect( vs.is_a? ActiveRecord::Relation ).to be true
      end
    end

    it 'returns correct relation' do
      surv = Survey.find('Salbal')
      sub = surv.subsections.first
      qs = sub.questions_for(surv)
      values = saved_sr_with_values.values_in_subsection(sub)

      expect(values.count).to eq(qs.count)
      expect(Question.where(id: values.pluck(:question_id)).pluck(:id)).to eq(qs.pluck(:id))
    end
  end

  describe "associations" do
    context "on new record" do
      let(:survey_response) { SurveyResponse.new }
      let(:election_profile) { build :ep_response }
      let(:salbal) { build :sal_response }

      it "allows county=" do
        survey_response.county = County.create!(name: 'Fake thing in fake file')
        expect(survey_response.county_id).to eq(County.last.id)
      end

      it "allows survey=" do
        survey_response.survey = Survey.last
        expect(survey_response.survey).to eq(Survey.last)
      end      

      it "allows election=" do
        e = ElectionYear.create!(year: 'New Thing')
        survey_response.election = e
        expect(survey_response.election).to eq(e)
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