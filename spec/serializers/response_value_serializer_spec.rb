require 'rails_helper'

RSpec.describe 'ResponseValueSerializer' do
  let(:sr)  { create :survey_response }
  let(:q)   { Question.find_by(field: 'salbaldesign') }
  let(:rv)  { ResponseValue.find_by(survey_response: sr, question: q) }
  let(:rv_serializer) { ResponseValueSerializer.new(rv) }
  let(:rv_adapter)  { ActiveModel::Serializer::Adapter.create(rv_serializer) }

  describe 'associations' do
    before(:each) { @relationships = rv_adapter.as_json[:data][:relationships] }

    it 'are question and survey_response' do
      expect(@relationships.keys.sort).to eq([:question, :survey_response])
    end

    it 'include correct question' do
      expect(@relationships[:question][:data]).to eq({type:'questions', id: q.id.to_s})
    end

    it 'include correct question' do
      expect(@relationships[:survey_response][:data]).to eq({type:'survey_responses', id: sr.id.to_s})
    end
  end

  describe 'attributes' do
    before(:each) { @attributes = rv_adapter.as_json[:data][:attributes] }
    it 'include :value, :data_type, :field, :na_value' do
      expect(@attributes.keys.sort).to eq([:data_type, :field, :na_value, :value])
    end

    it 'have correct values' do
      expect(@attributes[:data_type]).to  eq('integer')
      expect(@attributes[:field]).to      eq('salbaldesign')
      expect(@attributes[:na_value]).to   eq(false)
      expect(@attributes[:value]).to      eq(135)
    end
  end
end