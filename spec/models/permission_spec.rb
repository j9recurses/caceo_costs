require 'rails_helper'

RSpec::Matchers.define :allow do |*args|
  match do |permission|
    expect( permission.allow?(*args) ).to be true
  end
end

RSpec.describe Permission do
  let(:observer) { Permission.new( build(:observer) ) }
  let(:user) { Permission.new( FactoryGirl.build(:user) ) }
  let(:guest) { Permission.new( nil ) }

  let(:user_sr) { create :survey_response_ss }

  describe "as guest" do
    it 'permits properly' do
      expect( guest ).to allow :users, :login
      expect( guest ).to allow :users, :forgot_password
      expect( guest ).to allow :messages, :new
      expect( guest ).to allow :messages, :create
      expect( guest ).not_to allow :users, :profile
      expect( guest ).not_to allow :salbal, :show, user_sr
    end
  end

  describe "as user" do
    it 'permits county activity' do
      expect( user ).to allow :users, :login
      expect( user ).to allow :messages, :new
      expect( user ).to allow :messages, :create
      expect( user ).to allow :survey_responses, :index

      expect( user ).to allow :election_profile, :index
      expect( user ).to allow :election_profile, :new
      expect( user ).to allow :election_profile, :edit
      expect( user ).to allow :election_profile, :create
      expect( user ).to allow :election_profile, :update
      expect( user ).to allow :election_profile, :show
      expect( user ).to allow :election_profile, :destroy

      expect( user ).to allow :ssvbm, :index
      expect( user ).to allow :ssvbm, :new
      expect( user ).to allow :ssvbm, :edit
      expect( user ).to allow :ssvbm, :create
      expect( user ).to allow :ssvbm, :update
      expect( user ).to allow :ssvbm, :show
      expect( user ).to allow :ssvbm, :destroy

      expect( user ).to allow :salbal, :index
      expect( user ).to allow :salbal, :new
      expect( user ).to allow :salbal, :edit
      expect( user ).to allow :salbal, :create
      expect( user ).to allow :salbal, :update
      expect( user ).to allow :salbal, :show
      expect( user ).to allow :salbal, :destroy

      expect( user ).to allow :tech_voting_machines, :index
      expect( user ).to allow :tech_voting_machines, :new
      expect( user ).to allow :tech_voting_machines, :edit
      expect( user ).to allow :tech_voting_machines, :create
      expect( user ).to allow :tech_voting_machines, :update
      expect( user ).to allow :tech_voting_machines, :show
      expect( user ).to allow :tech_voting_machines, :delete
      expect( user ).to allow :tech_voting_machines, :destroy
    end
  end

  describe "as observer" do

  end
end