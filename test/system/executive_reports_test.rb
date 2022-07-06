require "application_system_test_case"

class ExecutiveReportsTest < ApplicationSystemTestCase
  setup do
    @executive_report = executive_reports(:one)
  end

  test "visiting the index" do
    visit executive_reports_url
    assert_selector "h1", text: "Executive reports"
  end

  test "should create executive report" do
    visit executive_reports_url
    click_on "New executive report"

    click_on "Create Executive report"

    assert_text "Executive report was successfully created"
    click_on "Back"
  end

  test "should update Executive report" do
    visit executive_report_url(@executive_report)
    click_on "Edit this executive report", match: :first

    click_on "Update Executive report"

    assert_text "Executive report was successfully updated"
    click_on "Back"
  end

  test "should destroy Executive report" do
    visit executive_report_url(@executive_report)
    click_on "Destroy this executive report", match: :first

    assert_text "Executive report was successfully destroyed"
  end
end
