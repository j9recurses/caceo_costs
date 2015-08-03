require 'rails_helper'

RSpec.describe 'SurveyReponseSerializer' do
  let(:sr)  { create :survey_response }
  let(:q)   { Question.find_by(field: 'salbaldesign') }
  let(:sr_serializer) { SurveyResponseSerializer.new(sr) }
  let(:sr_adapter)  { ActiveModel::Serializer::Adapter.create(sr_serializer) }

  describe 'associations' do
    before(:each) { @relationships = sr_adapter.as_json[:data][:relationships] }

    it 'are question and survey_response' do
      expect(@relationships.keys.sort).to eq([:county, :election, :survey, :values])
    end

    it 'include correct question' do
      expect(@relationships[:county][:data]).to eq({type:'counties', id: sr.county.id.to_s})
    end

    it 'include correct question' do
      # election_id expected to be ElectionYear#index value
      expect(@relationships[:election][:data]).to eq({type:'election_years', id: '14'})
    end
  end

  describe 'attributes' do
    before(:each) { @attributes = sr_adapter.as_json[:data][:attributes] }
    it 'contains :total' do
      expect(@attributes.keys.sort).to eq([:total])
    end

    it 'have correct values' do
      # maybe unsatisfying total, but correct! with sr total policy
      expect(@attributes[:total]).to  eq(0)
    end
  end

  describe 'array' do
    before(:each) do
      sr
      create :survey_response_ss_with_values
      create :survey_response_ep_with_values
      arr_serializer = ActiveModel::Serializer::ArraySerializer.new(
        SurveyResponse.all, each_serializer: SurveyResponseSerializer)
      @arr_adapter = ActiveModel::Serializer::Adapter::JsonApi.new(arr_serializer)
    end

    # it 'readout' do
    #   expect(@arr_adapter.as_json).to eq(true)
    # end
  end
end