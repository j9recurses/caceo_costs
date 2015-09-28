require 'rails_helper'

RSpec.describe TechSerializer do

  describe '#answered_count' do
    let(:tech) { create :tech_software_response }
    let(:tech_serializer) { tech; TechSerializer.new(TechVotingSoftware.all) }

    it 'counts answers' do
      expect(tech_serializer.answered_count).to eq(2)
    end
  end

end