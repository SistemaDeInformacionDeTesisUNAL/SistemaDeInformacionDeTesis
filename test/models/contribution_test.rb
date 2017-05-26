require 'test_helper'

class ContributionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save contribution without name" do
    contribution = Contribution.new
    contribution.state = rand(3)
    assert_not contribution.save, "saved contribution without a name"
  end
  test "should not save contribution without state" do
    contribution = Contribution.new
    contribution.name = "asdsaggsg"
    assert_not contribution.save, "saved contribution without a state"
  end
end
