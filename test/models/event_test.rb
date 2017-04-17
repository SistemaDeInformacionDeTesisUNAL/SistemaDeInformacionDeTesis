require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should be unique name" do
    name_event1 = Event.new
    name_event1.name = "dfghj"
    name_event1.save
    name_event2 = Event.new
    name_event2.name  = "dfghj"
    assert_not name_event2.save, "Saved a event with the same name"
  end
end
