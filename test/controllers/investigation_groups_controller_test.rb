require 'test_helper'

class InvestigationGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @investigation_group = investigation_groups(:one)
  end

  test "should get index" do
    get investigation_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_investigation_group_url
    assert_response :success
  end

  test "should create investigation_group" do
    assert_difference('InvestigationGroup.count') do
      post investigation_groups_url, params: { investigation_group: { create_date: @investigation_group.create_date, description: @investigation_group.description, name: @investigation_group.name } }
    end

    assert_redirected_to investigation_group_url(InvestigationGroup.last)
  end

  test "should show investigation_group" do
    get investigation_group_url(@investigation_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_investigation_group_url(@investigation_group)
    assert_response :success
  end

  test "should update investigation_group" do
    patch investigation_group_url(@investigation_group), params: { investigation_group: { create_date: @investigation_group.create_date, description: @investigation_group.description, name: @investigation_group.name } }
    assert_redirected_to investigation_group_url(@investigation_group)
  end
=begin
  test "should destroy investigation_group" do
    assert_difference('InvestigationGroup.count', -1) do
      delete investigation_group_url(@investigation_group)
    end

    assert_redirected_to investigation_groups_url
  end
=end
end
