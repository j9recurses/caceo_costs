require 'spec_helper'

RSpec::Matchers.define :allow do |*args|
  match do |permission|
    expect( permission.allow?(*args) ).to be true
  end
end

RSpec.describe Permission, focus: true do
  let(:observer) { Permission.new( build(:observer) ) }
  let(:user) { Permission.new( FactoryGirl.build(:user) ) }
  let(:guest) { Permission.new( nil ) }
  let(:user_salbal) { Salbal.where(county: 59).last }

  describe "as guest" do
    it 'permits properly' do
      expect( guest ).to allow :users, :login
      expect( guest ).to allow :users, :forgot_password
      expect( guest ).to allow :messages, :new
      expect( guest ).to allow :messages, :create
      expect( guest ).not_to allow :users, :profile
      expect( guest ).not_to allow :salbals, :show, user_salbal
    end
  end

  describe "as user" do
    it 'permits county activity' do
      expect( user ).to allow :users, :login
      expect( user ).to allow :messages, :new
      expect( user ).to allow :messages, :create
      expect( user ).to allow :salbals, :index
      expect( user ).to allow :users, :login
      expect( user ).to allow :users, :login
      expect( user ).to allow :users, :login
      expect( user ).to allow :users, :login
      expect( user ).to allow :users, :login

    end
  end

  describe "as observer" do

  end
end