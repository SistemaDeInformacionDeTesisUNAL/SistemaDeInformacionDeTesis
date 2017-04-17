require 'test_helper'

class HistoryGroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save history_group without bounding_date" do
    history = HistoryGroup.new
    history.state= 1
    history.investigation_group_id = InvestigationGroup.take.id
    assert_not history.save, "saved history_group without a bonding_date"
  end

  test "should not save history_group without state" do
    history = HistoryGroup.new
    history.bonding_date= Date.today
    history.investigation_group_id = InvestigationGroup.take.id
    assert_not history.save, "saved history_group without a state"
  end

  test "should not save history_group without investigation_group_id" do
    history = HistoryGroup.new
    history.bonding_date= Date.today
    history.state= 1
    assert_not history.save, "saved history_group without a investigation_group_id"
  end

end
