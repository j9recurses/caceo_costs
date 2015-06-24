require 'rails_helper'

RSpec.describe SurveyResponsesController, :type => :controller do
  let(:current_user) { create :user }
  let(:session)      { create(:survey_response).to_hash }

end
