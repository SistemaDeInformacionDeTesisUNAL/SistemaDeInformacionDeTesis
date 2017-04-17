require 'test_helper'

class InvestigationGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save investigation group without name" do
    inves_group = InvestigationGroup.new
    inves_group.create_date= Date.today
    assert_not inves_group.save, "saved investigation group without a name"
  end

  test "should not save investigation group without create_date" do
    inves_group = InvestigationGroup.new
    inves_group.name= "asad"
    assert_not inves_group.save, "saved investigation group without a create date"
  end
end
