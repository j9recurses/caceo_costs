require 'rails_helper'

RSpec.describe "Faqs", :type => :request do
  describe "GET /faqs" do
    it "is not accessible without user for permissions" do
      get faqs_path
      expect(response).to have_http_status(302)
    end
  end
end
