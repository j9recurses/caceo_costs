require 'rails_helper'

RSpec.describe Question do
  context "in isolation (no)" do
    before(:context) {
      @question = Question.new(
        survey: Survey.last,
        field: 'testq',
        label: 'a question for tests?',
        na_able: true,
        sum_able: true,
      )
    }
    after(:context) {
      @question.destroy
    }

    it 'response to na_able?' do
      expect(@question.na_able?).to eq(true)
    end
  end

  context "using election profile question" do
    before(:context) {
      @question = Survey.find_by(title: "Election Profile").questions.find_by(field: 'epvbmundel')
    }

    it 'knows its data type' do
      expect(@question.data_type).to eq('integer')
    end
  end
end