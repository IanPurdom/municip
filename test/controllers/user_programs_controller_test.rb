require 'test_helper'

class UserProgramsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_programs_create_url
    assert_response :success
  end

end
