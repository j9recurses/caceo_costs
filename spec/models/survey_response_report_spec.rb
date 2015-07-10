require 'rails_helper'

RSpec.describe SurveyResponseReport do
  let(:progress_array) { SurveyResponseReport.progress_array }

  describe '#progress_array' do
    it 'returns an array' do
      expect(progress_array.is_a? Array).to be true
    end
    # it 'has hashes with county names for keys' do
    #   hash_keys = progress_array.map { |e| e.keys.first }
    #   expect(progress_array.all? { |e| e.is_a? Hash }).to be true
    #   expect(progress_array).to be(true)
    #   expect(hash_keys & Survey.all.pluck(:title)).to eq Survey.all.pluck(:title)
    # end
  end
end
