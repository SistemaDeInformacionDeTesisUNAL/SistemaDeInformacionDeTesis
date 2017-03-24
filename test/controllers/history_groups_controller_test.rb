require 'test_helper'

class HistoryGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @history_group = history_groups(:one)
  end

  test "should get index" do
    get history_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_history_group_url
    assert_response :success
  end

  test "should create history_group" do
    assert_difference('HistoryGroup.count') do
      post history_groups_url, params: { history_group: { bonding_date: @history_group.bonding_date, exit_date: @history_group.exit_date, investigation_group_id: @history_group.investigation_group_id, student_id: @history_group.student_id, teacher_id: @history_group.teacher_id } }
    end

    assert_redirected_to history_group_url(HistoryGroup.last)
  end

  test "should show history_group" do
    get history_group_url(@history_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_history_group_url(@history_group)
    assert_response :success
  end

  test "should update history_group" do
    patch history_group_url(@history_group), params: { history_group: { bonding_date: @history_group.bonding_date, exit_date: @history_group.exit_date, investigation_group_id: @history_group.investigation_group_id, student_id: @history_group.student_id, teacher_id: @history_group.teacher_id } }
    assert_redirected_to history_group_url(@history_group)
  end

  test "should destroy history_group" do
    assert_difference('HistoryGroup.count', -1) do
      delete history_group_url(@history_group)
    end

    assert_redirected_to history_groups_url
  end
end
