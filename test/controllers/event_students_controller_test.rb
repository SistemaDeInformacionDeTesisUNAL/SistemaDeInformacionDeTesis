require 'test_helper'

class EventStudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event_student = event_students(:one)
  end

  test "should get index" do
    get event_students_url
    assert_response :success
  end

  test "should get new" do
    get new_event_student_url
    assert_response :success
  end

  test "should create event_student" do
    assert_difference('EventStudent.count') do
      post event_students_url, params: { event_student: { event_id: @event_student.event_id, student_id: @event_student.student_id } }
    end

    assert_redirected_to event_student_url(EventStudent.last)
  end

  test "should show event_student" do
    get event_student_url(@event_student)
    assert_response :success
  end

  test "should get edit" do
    get edit_event_student_url(@event_student)
    assert_response :success
  end

  test "should update event_student" do
    patch event_student_url(@event_student), params: { event_student: { event_id: @event_student.event_id, student_id: @event_student.student_id } }
    assert_redirected_to event_student_url(@event_student)
  end

  test "should destroy event_student" do
    assert_difference('EventStudent.count', -1) do
      delete event_student_url(@event_student)
    end

    assert_redirected_to event_students_url
  end
end
