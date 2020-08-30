require 'test_helper'

class RetweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get retweets_new_url
    assert_response :success
  end

  test "should get create" do
    get retweets_create_url
    assert_response :success
  end

  test "should get destroy" do
    get retweets_destroy_url
    assert_response :success
  end

end
