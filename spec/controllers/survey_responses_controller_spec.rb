require 'rails_helper'

RSpec.describe SurveyResponsesController, :type => :controller do
  let(:current_user)  { create :user }
  let(:sr)            { create :survey_response }
  let(:new_sr)        { build :survey_response }
  let(:auth_session)  { { user_id: current_user.id, county_id: current_user.county_id } }
  let(:sr_params) { { survey_id: 'Salbal', survey_response: 
    sr.attributes.merge(
      response_attributes: sr.response.attributes) } }

  describe "GET survey_response/:id" do
    it "has a 200 status code" do
      sr
      get :show, {id: sr.id}, auth_session
      expect(response.status).to eq(200)
    end
  end

  ##### I'm not sure how to get the session to operate properly in tests.
  # The actions seem to run in an isolated context...
  # describe "POST new sr to survey_response/:id" do
  #   it 'redirects to new' do
  #     get :new, { survey_id: 'Salbal', county_id: sr.county_id, election_id: sr.election_id }
  #     expect(response).to render_template(:new)
  #     expect(session[:survey_response]).to eq({})
  #     post :create, { survey_id: 'Salbal', survey_response: sr.attributes }, auth_session
  #     expect(response).to redirect_to(survey_response_path(assigns(:response_form)))
  #   end
  # end

end
