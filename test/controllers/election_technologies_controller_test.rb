require 'test_helper'

class ElectionTechnologiesControllerTest < ActionController::TestCase
  setup do
    @election_technology = election_technologies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:election_technologies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create election_technology" do
    assert_difference('ElectionTechnology.count') do
      post :create, election_technology: {  }
    end

    assert_redirected_to election_technology_path(assigns(:election_technology))
  end

  test "should show election_technology" do
    get :show, id: @election_technology
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @election_technology
    assert_response :success
  end

  test "should update election_technology" do
    patch :update, id: @election_technology, election_technology: {  }
    assert_redirected_to election_technology_path(assigns(:election_technology))
  end

  test "should destroy election_technology" do
    assert_difference('ElectionTechnology.count', -1) do
      delete :destroy, id: @election_technology
    end

    assert_redirected_to election_technologies_path
  end
end
