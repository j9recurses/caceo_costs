require 'rails_helper'

RSpec.describe Survey do

  context 'with subsections' do
    let(:survey) { Survey.find_by(category: "Salaries") }


    it 'responds to #subsection with Subsections' do
      expect(survey.subsections.first.class).to be Subsection
    end
  end
end