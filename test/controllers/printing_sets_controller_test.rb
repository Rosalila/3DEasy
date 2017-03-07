require 'test_helper'

class PrintingSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @printing_set = printing_sets(:one)
  end

  test "should get index" do
    get printing_sets_url
    assert_response :success
  end

  test "should get new" do
    get new_printing_set_url
    assert_response :success
  end

  test "should create printing_set" do
    assert_difference('PrintingSet.count') do
      post printing_sets_url, params: { printing_set: { doges: @printing_set.doges, name: @printing_set.name, printing_hub_id: @printing_set.printing_hub_id } }
    end

    assert_redirected_to printing_set_url(PrintingSet.last)
  end

  test "should show printing_set" do
    get printing_set_url(@printing_set)
    assert_response :success
  end

  test "should get edit" do
    get edit_printing_set_url(@printing_set)
    assert_response :success
  end

  test "should update printing_set" do
    patch printing_set_url(@printing_set), params: { printing_set: { doges: @printing_set.doges, name: @printing_set.name, printing_hub_id: @printing_set.printing_hub_id } }
    assert_redirected_to printing_set_url(@printing_set)
  end

  test "should destroy printing_set" do
    assert_difference('PrintingSet.count', -1) do
      delete printing_set_url(@printing_set)
    end

    assert_redirected_to printing_sets_url
  end
end
