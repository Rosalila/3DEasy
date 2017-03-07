require 'test_helper'

class PrintingHubsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @printing_hub = printing_hubs(:one)
  end

  test "should get index" do
    get printing_hubs_url
    assert_response :success
  end

  test "should get new" do
    get new_printing_hub_url
    assert_response :success
  end

  test "should create printing_hub" do
    assert_difference('PrintingHub.count') do
      post printing_hubs_url, params: { printing_hub: { name: @printing_hub.name } }
    end

    assert_redirected_to printing_hub_url(PrintingHub.last)
  end

  test "should show printing_hub" do
    get printing_hub_url(@printing_hub)
    assert_response :success
  end

  test "should get edit" do
    get edit_printing_hub_url(@printing_hub)
    assert_response :success
  end

  test "should update printing_hub" do
    patch printing_hub_url(@printing_hub), params: { printing_hub: { name: @printing_hub.name } }
    assert_redirected_to printing_hub_url(@printing_hub)
  end

  test "should destroy printing_hub" do
    assert_difference('PrintingHub.count', -1) do
      delete printing_hub_url(@printing_hub)
    end

    assert_redirected_to printing_hubs_url
  end
end
