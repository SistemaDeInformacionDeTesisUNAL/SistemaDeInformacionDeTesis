require 'test_helper'

class TagTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save tag without name" do
    tag = Tag.new
    assert_not tag.save, "saved contribution without a name"
  end
  test "should save tag with name" do
    tag = Tag.new
    tag.name = "newtaged"
    assert tag.save, "not saved contribution"
  end
end
