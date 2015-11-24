require 'rails_helper'

RSpec::Matchers.define :allow do |*args|
  match do |permission|
    expect( permission.allow?(*args) ).to be true
  end
end

RSpec.describe Permission do
  let(:observer) { Permission.new( build(:observer) ) }
  let(:user) { FactoryGirl.create :user }
  let(:user_permit) { Permission.new( user ) }
  let(:guest) { Permission.new( nil ) }

  let(:user_sr) { create :survey_response_ss }

  describe "as guest" do
    it 'permits properly' do
      expect( guest ).to allow :users, :login
      expect( guest ).to allow :users, :forgot_password
      expect( guest ).to allow :messages, :new
      expect( guest ).to allow :messages, :create
      expect( guest ).not_to allow :users, :profile
      expect( guest ).not_to allow :survey_responses, :index, user_sr
    end
  end

  describe "as user" do
    it 'permits county activity' do
      expect( user_permit ).to allow :users, :login
      expect( user_permit ).to allow :messages, :new
      expect( user_permit ).to allow :messages, :create

      expect( user_permit ).to allow :survey_responses, :index
      expect( user_permit ).to allow :survey_responses, :new, user
      expect( user_permit ).to allow :survey_responses, :edit, user
      expect( user_permit ).to allow :survey_responses, :create, user
      expect( user_permit ).to allow :survey_responses, :update, user
      expect( user_permit ).to allow :survey_responses, :show, user
      expect( user_permit ).to allow :survey_responses, :destroy, user

      expect( user_permit ).to allow :tech_voting_machines, :index
      expect( user_permit ).to allow :tech_voting_machines, :new, user
      expect( user_permit ).to allow :tech_voting_machines, :edit, user
      expect( user_permit ).to allow :tech_voting_machines, :create, user
      expect( user_permit ).to allow :tech_voting_machines, :update, user
      expect( user_permit ).to allow :tech_voting_machines, :show, user
      expect( user_permit ).to allow :tech_voting_machines, :delete, user
      expect( user_permit ).to allow :tech_voting_machines, :destroy, user
    end
  end

  describe "as observer" do

  end
end