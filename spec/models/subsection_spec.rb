require 'rails_helper'

RSpec.describe Subsection do
  context 'with no survey' do
    let(:subsection) { Subsection.new }

    it 'responds to #survey_totals' do
      expect(subsection).to respond_to(:survey_totals)
    end

    it 'responds to #surveys' do
      expect(subsection).to respond_to(:surveys)
    end
  end
end