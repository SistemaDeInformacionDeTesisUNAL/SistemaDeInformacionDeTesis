require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should not save profile without entity" do
    profile = Profile.new
    profile.URL= "sdhweuhhfhfhe"
    assert_not profile.save, "saved profile without a entity"
  end

  test "should not save profile without URL" do
    profile = Profile.new
    profile.entity= "profileahsh"
    assert_not profile.save, "saved profile without a URL"
  end
end
