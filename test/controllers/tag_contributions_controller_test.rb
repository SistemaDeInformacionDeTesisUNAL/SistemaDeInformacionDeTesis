require 'test_helper'

class TagContributionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag_contribution = tag_contributions(:one)
  end

  test "should get index" do
    get tag_contributions_url
    assert_response :success
  end

  test "should get new" do
    get new_tag_contribution_url
    assert_response :success
  end

  test "should create tag_contribution" do
    assert_difference('TagContribution.count') do
      post tag_contributions_url, params: { tag_contribution: { contribution_id: @tag_contribution.contribution_id, tag_id: @tag_contribution.tag_id } }
    end

    assert_redirected_to tag_contribution_url(TagContribution.last)
  end

  test "should show tag_contribution" do
    get tag_contribution_url(@tag_contribution)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_contribution_url(@tag_contribution)
    assert_response :success
  end

  test "should update tag_contribution" do
    patch tag_contribution_url(@tag_contribution), params: { tag_contribution: { contribution_id: @tag_contribution.contribution_id, tag_id: @tag_contribution.tag_id } }
    assert_redirected_to tag_contribution_url(@tag_contribution)
  end

  test "should destroy tag_contribution" do
    assert_difference('TagContribution.count', -1) do
      delete tag_contribution_url(@tag_contribution)
    end

    assert_redirected_to tag_contributions_url
  end
  
end
