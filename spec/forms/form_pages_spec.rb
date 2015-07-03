require 'rails_helper'
require './app/forms/form_pages'

RSpec.describe FormPages do
  let(:pages) { FormPages.new(Survey.find 'Salbal') }
  let(:questions) { Question.where(survey_id: 'Salbal') }

  # describe 'questions' do
  #   it 'has all qs' do
  #     expect(pages.questions.size).to eq Question.where(survey_id: 'Salbal').count
  #   end
  # end

  describe '#current_page' do
    it 'has 12 questions' do
      expect(pages.current_page.size).to be 12
    end

    it 'returns questions' do
      expect(pages.current_page.all? { |q| q.is_a? Question }).to be true
    end

    it 'flips pages' do
      page_one_ids = pages.current_page.map { |q| q.id }
      pages.step_forward
      page_two_ids = pages.current_page.map { |q| q.id }
      expect(page_one_ids & page_two_ids).to eq []
    end
  end

  describe '#total_steps' do
    it 'correct' do
      expect(pages.total_steps).to eq (questions.size / 12.to_f).ceil
    end
  end

  it 'second page truncated, no nils' do
    second_page = pages.step_forward.current_page
    expect(second_page.size).to be 4
    expect(second_page.compact.size).to be 4
  end
end