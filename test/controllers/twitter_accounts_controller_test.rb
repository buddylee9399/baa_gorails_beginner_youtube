require "test_helper"

class TwitterAccountsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get twitter_accounts_index_url
    assert_response :success
  end

  test "should get new" do
    get twitter_accounts_new_url
    assert_response :success
  end

  test "should get edit" do
    get twitter_accounts_edit_url
    assert_response :success
  end

  test "should get show" do
    get twitter_accounts_show_url
    assert_response :success
  end
end
