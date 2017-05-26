require 'test_helper'

class UbicationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save ubication without link" do
    ubication = Ubication.new
    ubication.link= "ytyrtrywef"
    assert_not ubication.save, "saved ubication without a link"
  end

  test "should be unique link" do
    ubic1 = Ubication.new
    ubic1.link = "asdhergrgr"
    ubic1.save
    ubic2 = Ubication.new
    ubic2.link = "asdhergrgr"
    assert_not ubic2.save, "Saved a ubication with the same link"
  end
end
