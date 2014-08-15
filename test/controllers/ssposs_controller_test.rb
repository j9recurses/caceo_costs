require 'test_helper'

class SspossControllerTest < ActionController::TestCase
  setup do
    @sspos = ssposs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ssposs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sspos" do
    assert_difference('Sspos.count') do
      post :create, sspos: {  }
    end

    assert_redirected_to sspos_path(assigns(:sspos))
  end

  test "should show sspos" do
    get :show, id: @sspos
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sspos
    assert_response :success
  end

  test "should update sspos" do
    patch :update, id: @sspos, sspos: {  }
    assert_redirected_to sspos_path(assigns(:sspos))
  end

  test "should destroy sspos" do
    assert_difference('Sspos.count', -1) do
      delete :destroy, id: @sspos
    end

    assert_redirected_to ssposs_path
  end
end
