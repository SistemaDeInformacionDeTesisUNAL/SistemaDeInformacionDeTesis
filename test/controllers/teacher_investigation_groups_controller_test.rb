require 'test_helper'

class TeacherInvestigationGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @teacher_investigation_group = teacher_investigation_groups(:one)
  end

  test "should get index" do
    get teacher_investigation_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_teacher_investigation_group_url
    assert_response :success
  end

  test "should create teacher_investigation_group" do
    assert_difference('TeacherInvestigationGroup.count') do
      post teacher_investigation_groups_url, params: { teacher_investigation_group: { investigation_group_id: @teacher_investigation_group.investigation_group_id, teacher_id: @teacher_investigation_group.teacher_id } }
    end

    assert_redirected_to teacher_investigation_group_url(TeacherInvestigationGroup.last)
  end

  test "should show teacher_investigation_group" do
    get teacher_investigation_group_url(@teacher_investigation_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_teacher_investigation_group_url(@teacher_investigation_group)
    assert_response :success
  end

  test "should update teacher_investigation_group" do
    patch teacher_investigation_group_url(@teacher_investigation_group), params: { teacher_investigation_group: { investigation_group_id: @teacher_investigation_group.investigation_group_id, teacher_id: @teacher_investigation_group.teacher_id } }
    assert_redirected_to teacher_investigation_group_url(@teacher_investigation_group)
  end
=begin
  test "should destroy teacher_investigation_group" do
    assert_difference('TeacherInvestigationGroup.count', -1) do
      delete teacher_investigation_group_url(@teacher_investigation_group)
    end

    assert_redirected_to teacher_investigation_groups_url
  end
=end
end
