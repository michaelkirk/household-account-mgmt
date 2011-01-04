require 'test_helper'

class HouseholdsControllerTest < ActionController::TestCase
  setup do
    @household = households(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:households)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create household" do
    assert_difference('Household.count') do
      post :create, :household => @household.attributes
    end

    assert_redirected_to household_path(assigns(:household))
  end

  test "should show household" do
    get :show, :id => @household.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @household.to_param
    assert_response :success
  end

  test "should update household" do
    put :update, :id => @household.to_param, :household => @household.attributes
    assert_redirected_to household_path(assigns(:household))
  end

  test "should destroy household" do
    assert_difference('Household.count', -1) do
      delete :destroy, :id => @household.to_param
    end

    assert_redirected_to households_path
  end
end
