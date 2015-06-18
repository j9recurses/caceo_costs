require 'rails_helper'

RSpec.describe ResponseForm do
  let(:form_class) { Class.new(Reform::Form) }
  describe '::model' do
    it 'returns a Reform module' do
      rf = ResponseForm.build('Salbal')
      expect(rf.ancestors.include?(Reform::Form::Module)).to be true
    end
    

    it 'adds association property' do
      form_class.include(ResponseForm.build('Salbal'))
      expect(form_class.instance_methods.include?(:response)).to be true
      expect(form_class.instance_methods.include?(:response=)).to be true
    end
  end  
end