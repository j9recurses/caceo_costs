require 'rails_helper'
require 'action_controller/metal/strong_parameters'
require './app/services/survey_na'

RSpec.describe SurveyNa do
  before(:all) {
    @cols = ElectionProfile.na_questions.pluck(:field).in_groups_of(16, false)
    view_params = []
    @cols.each do |col_group|
      group_fields = []
      col_group.each do |col_name|
        group_fields << "#{col_name}_value" << "#{col_name}_na"        
      end
      view_params << group_fields
    end
    @param_keys = view_params

    param_hash_0_empty = Hash[ @param_keys[0].map { |k| [k,""] } ]
    @params_0_empty = ActionController::Parameters.new(param_hash_0_empty)

    # "1" params, which also sets all _na to true
    param_hash_0_na = Hash[ @param_keys[0].map { |k| [k,"1"] } ]         
    @params_0 = ActionController::Parameters.new(param_hash_0_na)
    @session_0 = SurveyNa.new({}, @params_0).merged_session

    # "0" params, which also sets all _na to false
    params_hash_1 = Hash[ @param_keys[1].map { |k| [k,"0"] } ]
    @params_1 = ActionController::Parameters.new(params_hash_1)
    @session_1 = SurveyNa.new(@session_0, @params_1).merged_session

    # empty params (_na fields will just get thrown out in this case)
    params_hash_2_empty = Hash[ @param_keys[2].map { |k| [k,'']  } ]
    @params_2 = ActionController::Parameters.new( params_hash_2_empty )
  }

  describe 'merged session' do
    context 'with empty params' do
      it 'starts with the right params' do
        expect(@params_0_empty.size).to be(32)
      end

      it 'has subset of fields of its model' do
        survey_session = SurveyNa.new({}, @params_0_empty).merged_session
        expect(survey_session.size).to be(16)
        expect(survey_session.keys - ElectionProfile.column_names).to eq([])
      end
    end

    context 'with all fields na' do
      it 'writes na value over _value values' do
        expect(@session_0.values.any? { |e| e == "1" }).to be(false)
      end
    end

    context 'with multiple pages' do
      it 'preserves first page' do
        expect(@session_1.to_a & @session_0.to_a).to eq(@session_0.to_a)
      end

      it 'contains correct fields' do
        expect(@session_1.keys - ElectionProfile.column_names).to eq([])
        expect(@session_1.keys & ( @cols[0] + @cols[1] )).to eq(@session_1.keys)
      end

      it 'does not overwrite page 2 _values' do
        expect(@cols[1].all? {|k| @session_1[k] == "0" }).to be(true)
      end
    end


    context 'with empty session as not applicable' do
      before(:context) {
        @session_2_session = SurveyNa.new(@session_1, @params_2).merged_session(empty_not_applicable: :session)
      }

      it 'makes no change to contentful fields from params 0 and 1' do
        expect( Hash[@session_2_session.to_a & @session_0.to_a] ).to eq(@session_0)
        expect( Hash[@session_2_session.to_a & @session_1.to_a] ).to eq(@session_1)
      end

      context 'changes empty params from earlier' do
        before(:context) {
          @session_0_empty = SurveyNa.new( {}, @params_0_empty ).merged_session
          @session_1_empty = SurveyNa.new( @session_0_empty, @params_1 ).merged_session
          @session_2_empty = SurveyNa.new( @session_1_empty, @params_2 ).merged_session(empty_not_applicable: :session)
        }
        it 'changes empty params' do
          expect(Hash[ @session_2_empty.to_a & @session_0_empty.to_a ]).not_to eq(@session_0_empty)
        end

        it 'marks earlier empty page as NOT APPLICABLE' do
          page_one_hash = Hash[ @session_2_empty.to_a & @session_0_empty.to_a ]
          expect(page_one_hash.values - SurveyNa::NA_VALUES.values ).to eq([])
        end

        it 'marks own page as NOT APPLICABLE' do
          own_params = Hash[ @session_2_empty.to_a - (@session_0_empty.to_a + @session_1_empty.to_a) ]
          puts own_params
          expect( own_params.values - SurveyNa::NA_VALUES.values ).to eq([])
        end

        it 'leaves behind no empty session values' do
          expect( @session_2_empty.values.any? { |v| v == "" } ).to be(false)
        end
      end
    end

    context 'with empty params as not applicable' do
      before(:context) {
        @session_2_session = SurveyNa.new(@session_1, @params_2).merged_session(empty_not_applicable: :params)
      }

      it 'makes no change to contentful fields from params 0 and 1' do
        expect( Hash[@session_2_session.to_a & @session_0.to_a] ).to eq(@session_0)
        expect( Hash[@session_2_session.to_a & @session_1.to_a] ).to eq(@session_1)
      end

      context 'does not change empty params from earlier' do
        before(:context) {
          @session_0_empty = SurveyNa.new({}, @params_0_empty).merged_session
          @session_1_empty = SurveyNa.new( @session_0_empty, @params_1).merged_session
          @session_2_empty = SurveyNa.new( @session_1_empty, @params_2).merged_session(empty_not_applicable: :params)
        }
        it 'changes empty params' do
          expect(Hash[ @session_2_empty.to_a & @session_0_empty.to_a ]).to eq(@session_0_empty)
        end

        it 'does not mark earlier empty page as NOT APPLICABLE' do
          page_one_hash = Hash[ @session_2_empty.to_a & @session_0_empty.to_a ]
          expect(page_one_hash.values - SurveyNa::NA_VALUES.values ).not_to eq([])
        end

        it 'marks own page as NOT APPLICABLE' do
          own_params = Hash[ @session_2_empty.to_a - (@session_0_empty.to_a + @session_1_empty.to_a) ]
          puts own_params
          expect( own_params.values - SurveyNa::NA_VALUES.values ).to eq([])
        end

        it 'leaves behind earlier session values' do
          expect( @session_2_empty.values.any? { |v| v == "" } ).to be(true)
        end
      end
    end
  end
end