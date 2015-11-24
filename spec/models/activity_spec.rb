require 'rails_helper'

RSpec.describe Activity do
  describe 'time period methods' do
    before :context do
      SurveyResponse.destroy_all
      Election.destroy_all
      @ss  = create :survey_response_ss

      ss_clone = SurveyResponse.new( @ss.attributes )
      ss_clone.id = nil
      ss_clone.response = Sspw.new
      ss_clone.save!

      @sal = create :survey_response_sal
      @ep  = create :survey_response_ep

      @sal.tap do |sr|
        sr.created_at = 35.days.ago
        sr.updated_at = 34.days.ago
      end

      @ep.tap do |sr|
        sr.created_at = 6.days.ago
        sr.updated_at = 5.days.ago
      end

      @sal.save!
      @ep.save!
    end

    after :context do
      SurveyResponse.destroy_all
      Election.destroy_all
    end

    describe '#today' do
      before(:context) { @today = Activity.today }

      it 'returns a relation' do
        expect(@today.class).to eq(SurveyResponse::ActiveRecord_Relation)
      end

      it 'returns record in range' do
        expect(@today.to_a.size).to eq(1)
        expect(@today.first.survey_category).to eq(@ss.survey.category)
        expect(@today.first.category_count).to eq(2)
      end
    end

    describe '#last_week' do
      before(:context) { @week = Activity.last_week }

      it 'returns a relation' do
        expect(@week.class).to eq(SurveyResponse::ActiveRecord_Relation)
      end

      it 'returns record in range' do
        expect(@week.to_a.size).to eq(1)
        expect(@week.first.survey_category).to eq(@ep.survey.category)
        expect(@week.first.category_count).to eq(1)
      end
    end

    describe '#last_month' do
      before(:context) { @month = Activity.last_month }

      it 'returns a relation' do
        expect(@month.class).to eq(SurveyResponse::ActiveRecord_Relation)
      end

      it 'returns record in range' do
        expect(@month.to_a.size).to eq(1)
        expect(@month.first.survey_category).to eq(@sal.survey.category)
        expect(@month.first.category_count).to eq(1)
      end
    end

  end
end
