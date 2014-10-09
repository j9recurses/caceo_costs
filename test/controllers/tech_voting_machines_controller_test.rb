require 'test_helper'

class TechVotingMachinesControllerTest < ActionController::TestCase
  setup do
    @tech_voting_machine = tech_voting_machines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tech_voting_machines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tech_voting_machine" do
    assert_difference('TechVotingMachine.count') do
      post :create, tech_voting_machine: { equip_make: @tech_voting_machine.equip_make, offset_amount: @tech_voting_machine.offset_amount, offset_funds_type: @tech_voting_machine.offset_funds_type, purchase_dt: @tech_voting_machine.purchase_dt, purchase_price: @tech_voting_machine.purchase_price, quantity: @tech_voting_machine.quantity, voting_equip_type: @tech_voting_machine.voting_equip_type }
    end

    assert_redirected_to tech_voting_machine_path(assigns(:tech_voting_machine))
  end

  test "should show tech_voting_machine" do
    get :show, id: @tech_voting_machine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tech_voting_machine
    assert_response :success
  end

  test "should update tech_voting_machine" do
    patch :update, id: @tech_voting_machine, tech_voting_machine: { equip_make: @tech_voting_machine.equip_make, offset_amount: @tech_voting_machine.offset_amount, offset_funds_type: @tech_voting_machine.offset_funds_type, purchase_dt: @tech_voting_machine.purchase_dt, purchase_price: @tech_voting_machine.purchase_price, quantity: @tech_voting_machine.quantity, voting_equip_type: @tech_voting_machine.voting_equip_type }
    assert_redirected_to tech_voting_machine_path(assigns(:tech_voting_machine))
  end

  test "should destroy tech_voting_machine" do
    assert_difference('TechVotingMachine.count', -1) do
      delete :destroy, id: @tech_voting_machine
    end

    assert_redirected_to tech_voting_machines_path
  end
end
