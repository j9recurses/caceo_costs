require 'rails_helper'

RSpec.describe Survey do
  let(:survey) { Survey.new }

  it 'responds to #totals_subsections' do
    expect(survey).to respond_to(:totals_subsections)
  end

  it 'responds to #subsections' do
    expect(survey).to respond_to(:subsections)
  end

  # Not implemented
  # context 'with subsections' do
  #   let(:survey) { Survey.find_by(category: "Salaries") }

  #   it '#totals_subsections returns Subsections' do
  #     expect(survey.totals_subsections.first.class).to be Subsection
  #   end
  # end
end