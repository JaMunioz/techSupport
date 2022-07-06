require "test_helper"

class ExecutiveReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @executive_report = executive_reports(:one)
  end

  test "should get index" do
    get executive_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_executive_report_url
    assert_response :success
  end

  test "should create executive_report" do
    assert_difference("ExecutiveReport.count") do
      post executive_reports_url, params: { executive_report: {  } }
    end

    assert_redirected_to executive_report_url(ExecutiveReport.last)
  end

  test "should show executive_report" do
    get executive_report_url(@executive_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_executive_report_url(@executive_report)
    assert_response :success
  end

  test "should update executive_report" do
    patch executive_report_url(@executive_report), params: { executive_report: {  } }
    assert_redirected_to executive_report_url(@executive_report)
  end

  test "should destroy executive_report" do
    assert_difference("ExecutiveReport.count", -1) do
      delete executive_report_url(@executive_report)
    end

    assert_redirected_to executive_reports_url
  end
end
