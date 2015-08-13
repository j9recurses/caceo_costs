require 'rails_helper'

RSpec.describe ResponseForm do
  let(:sr) { build :survey_response_ss }
  let(:srf){ SurveyResponseForm.new(sr) }
  let(:ep_srf) { SurveyResponseForm.new( build(:survey_response_ep) ) }
  let(:ssbal) { build :ssbal }
  let(:ep)    { build :ep }
  let(:ep_rf) { ResponseForm.new( ep ) }

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

  describe 'BitMaskable' do
    it 'responds to _multi_select' do
      expect(ep_rf.respond_to?(:eplangvra_multi_select)).to be(true)
      expect(ep_rf.respond_to?(:eplangvra_multi_select=)).to be(true)
      expect(ep_rf.respond_to?(:eplangcaec_multi_select)).to be(true)
      expect(ep_rf.respond_to?(:eplangcaec_multi_select=)).to be(true)
    end

    it 'reads out languages' do
      ep.eplangvra = 92
      rf = ResponseForm.new(ep)
      expect(rf.eplangvra_multi_select).to eq(["Vietnamese", "Japanese", "Korean", "Asian Indian (Hindi)"])
    end


    it 'persists bit value' do
      ep_rf.validate({'eplangvra_multi_select' => ["Vietnamese", "Japanese", "Korean", "Asian Indian (Hindi)", ""]})
      ep_rf.sync
      expect(ep_rf.eplangvra).to eq(92)
    end
  end
end
