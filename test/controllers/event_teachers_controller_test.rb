require 'test_helper'

class EventTeachersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_teacher = event_teachers(:one)
  end

  test "should get index" do
    get event_teachers_url
    assert_response :success
  end

  test "should get new" do
    get new_event_teacher_url
    assert_response :success
  end

  test "should create event_teacher" do
    assert_difference('EventTeacher.count') do
      post event_teachers_url, params: { event_teacher: { event_id: @event_teacher.event_id, teacher_id: @event_teacher.teacher_id } }
    end

    assert_redirected_to event_teacher_url(EventTeacher.last)
  end

  test "should show event_teacher" do
    get event_teacher_url(@event_teacher)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_teacher_url(@event_teacher)
    assert_response :success
  end

  test "should update event_teacher" do
    patch event_teacher_url(@event_teacher), params: { event_teacher: { event_id: @event_teacher.event_id, teacher_id: @event_teacher.teacher_id } }
    assert_redirected_to event_teacher_url(@event_teacher)
  end

  test "should destroy event_teacher" do
    assert_difference('EventTeacher.count', -1) do
      delete event_teacher_url(@event_teacher)
    end

    assert_redirected_to event_teachers_url
  end
end
