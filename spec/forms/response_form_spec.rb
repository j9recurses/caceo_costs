require 'rails_helper'

RSpec.describe ResponseForm do
  let(:sr) { create :survey_response_ss }
  let(:srf){ SurveyResponseForm.new(sr) }

  describe '::model' do
    it 'returns a Reform class' do
      rf = ResponseForm.new(Salbal.new)
      expect(rf.class.superclass).to be(Reform::Form)
    end

    it 'adds association property' do
      expect(srf.class.instance_methods.include?(:response)).to be true
      expect(srf.class.instance_methods.include?(:response=)).to be true
    end
  end  
end