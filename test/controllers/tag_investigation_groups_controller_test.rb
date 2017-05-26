require 'test_helper'

class TagInvestigationGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag_investigation_group = tag_investigation_groups(:one)
  end

  test "should get index" do
    get tag_investigation_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_tag_investigation_group_url
    assert_response :success
  end

  test "should create tag_investigation_group" do
    assert_difference('TagInvestigationGroup.count') do
      post tag_investigation_groups_url, params: { tag_investigation_group: { investigation_group_id: @tag_investigation_group.investigation_group_id, tag_id: @tag_investigation_group.tag_id } }
    end

    assert_redirected_to tag_investigation_group_url(TagInvestigationGroup.last)
  end

  test "should show tag_investigation_group" do
    get tag_investigation_group_url(@tag_investigation_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_investigation_group_url(@tag_investigation_group)
    assert_response :success
  end

  test "should update tag_investigation_group" do
    patch tag_investigation_group_url(@tag_investigation_group), params: { tag_investigation_group: { investigation_group_id: @tag_investigation_group.investigation_group_id, tag_id: @tag_investigation_group.tag_id } }
    assert_redirected_to tag_investigation_group_url(@tag_investigation_group)
  end
  test "should destroy tag_investigation_group" do
    assert_difference('TagInvestigationGroup.count', -1) do
      delete tag_investigation_group_url(@tag_investigation_group)
    end

    assert_redirected_to tag_investigation_groups_url
  end
end
