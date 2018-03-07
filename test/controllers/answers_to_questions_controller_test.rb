require 'test_helper'

class AnswersToQuestionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get answers_to_questions_new_url
    assert_response :success
  end

  test "should get create" do
    get answers_to_questions_create_url
    assert_response :success
  end

  test "should get edit" do
    get answers_to_questions_edit_url
    assert_response :success
  end

  test "should get update" do
    get answers_to_questions_update_url
    assert_response :success
  end

  test "should get destroy" do
    get answers_to_questions_destroy_url
    assert_response :success
  end

end
