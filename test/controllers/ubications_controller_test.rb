require 'test_helper'

class UbicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ubication = ubications(:one)
  end

  test "should get index" do
    get ubications_url
    assert_response :success
  end

  test "should get new" do
    get new_ubication_url
    assert_response :success
  end

  test "should create ubication" do
    assert_difference('Ubication.count') do
      post ubications_url, params: { ubication: { contribution_id: @ubication.contribution_id, link: @ubication.link } }
    end

    assert_redirected_to ubication_url(Ubication.last)
  end

  test "should show ubication" do
    get ubication_url(@ubication)
    assert_response :success
  end

  test "should get edit" do
    get edit_ubication_url(@ubication)
    assert_response :success
  end

  test "should update ubication" do
    patch ubication_url(@ubication), params: { ubication: { contribution_id: @ubication.contribution_id, link: @ubication.link } }
    assert_redirected_to ubication_url(@ubication)
  end

  test "should destroy ubication" do
    assert_difference('Ubication.count', -1) do
      delete ubication_url(@ubication)
    end

    assert_redirected_to ubications_url
  end
end
