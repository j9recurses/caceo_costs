# require 'rails_helper'

# RSpec.describe "Salbals", :type => :request do
#   describe "GET /salbals" do
#     it "redirects to login path" do
#       get salbals_path
#       expect(response).to redirect_to(login_path)
#     end
#   end

#   describe 'GET /salbals signed in' do
#     it 'lets me sign in' do
#       visit '/login'
#       within(".Sign_Form") do
#         fill_in 'username_or_email', with: 'test_user'
#         fill_in 'login_password', with: 'test_pass'
#       end
#       click_button 'Log In'
#       puts page.text

#       expect(page).to have_content('Welcome')
#     end


#     it 'redirects me to a new salbal' do
#       visit 'election_years/11/categories'
#       click_link 'Sample, Official, Provisional And VBM Ballots'
#       # expect(page).to have_content()
#     end
#   end
# end
