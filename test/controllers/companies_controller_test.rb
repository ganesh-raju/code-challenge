require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase

  def setup
    @company = companies(:hometown_painting)
    @mainstreet_company = companies(:mystreet_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text "#{@company.city}, #{@company.state}"
  end

  test "Update company without getmainstreet domain email" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text "Must be a @getmainstreet.com account"
  end

  test "Update company with getmainstreet domain email" do
    visit edit_company_path(@mainstreet_company)

    within("form#edit_company_#{@mainstreet_company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text "Changes Saved"
  end


  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@test.com")
      click_button "Create Company"
    end

    assert_text "Must be a @getmainstreet.com account"
  end


  test "Create with getmainstreet domain" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "getmainstreet domain")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "getmainstreet domain", last_company.name
    assert_equal "28173", last_company.zip_code
  end


  test "Create without email" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "getmainstreet domain")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "getmainstreet domain", last_company.name
    assert_equal "28173", last_company.zip_code
  end

  test "Delete" do
    company = companies(:wolf_painting)
    assert_difference('Company.count', -1) do
      delete :destroy, id: company
    end
    assert_redirected_to companies_url
  end
end
