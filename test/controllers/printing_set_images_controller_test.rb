require 'test_helper'

class PrintingSetImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @printing_set_image = printing_set_images(:one)
  end

  test "should get index" do
    get printing_set_images_url
    assert_response :success
  end

  test "should get new" do
    get new_printing_set_image_url
    assert_response :success
  end

  test "should create printing_set_image" do
    assert_difference('PrintingSetImage.count') do
      post printing_set_images_url, params: { printing_set_image: { image: @printing_set_image.image, printing_set_id: @printing_set_image.printing_set_id } }
    end

    assert_redirected_to printing_set_image_url(PrintingSetImage.last)
  end

  test "should show printing_set_image" do
    get printing_set_image_url(@printing_set_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_printing_set_image_url(@printing_set_image)
    assert_response :success
  end

  test "should update printing_set_image" do
    patch printing_set_image_url(@printing_set_image), params: { printing_set_image: { image: @printing_set_image.image, printing_set_id: @printing_set_image.printing_set_id } }
    assert_redirected_to printing_set_image_url(@printing_set_image)
  end

  test "should destroy printing_set_image" do
    assert_difference('PrintingSetImage.count', -1) do
      delete printing_set_image_url(@printing_set_image)
    end

    assert_redirected_to printing_set_images_url
  end
end
