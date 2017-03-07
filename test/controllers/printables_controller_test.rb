require 'test_helper'

class PrintablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @printable = printables(:one)
  end

  test "should get index" do
    get printables_url
    assert_response :success
  end

  test "should get new" do
    get new_printable_url
    assert_response :success
  end

  test "should create printable" do
    assert_difference('Printable.count') do
      post printables_url, params: { printable: { github_repo: @printable.github_repo, printing_set_id: @printable.printing_set_id } }
    end

    assert_redirected_to printable_url(Printable.last)
  end

  test "should show printable" do
    get printable_url(@printable)
    assert_response :success
  end

  test "should get edit" do
    get edit_printable_url(@printable)
    assert_response :success
  end

  test "should update printable" do
    patch printable_url(@printable), params: { printable: { github_repo: @printable.github_repo, printing_set_id: @printable.printing_set_id } }
    assert_redirected_to printable_url(@printable)
  end

  test "should destroy printable" do
    assert_difference('Printable.count', -1) do
      delete printable_url(@printable)
    end

    assert_redirected_to printables_url
  end
end
