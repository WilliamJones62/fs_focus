require "application_system_test_case"

class FsFocusItemsTest < ApplicationSystemTestCase
  setup do
    @fs_focus_item = fs_focus_items(:one)
  end

  test "visiting the index" do
    visit fs_focus_items_url
    assert_selector "h1", text: "Fs Focus Items"
  end

  test "creating a Fs focus item" do
    visit fs_focus_items_url
    click_on "New Fs Focus Item"

    fill_in "Customer", with: @fs_focus_item.customer
    fill_in "End date", with: @fs_focus_item.end_date
    fill_in "Part code", with: @fs_focus_item.part_code
    fill_in "Part desc", with: @fs_focus_item.part_desc
    fill_in "Rep", with: @fs_focus_item.rep
    fill_in "Start date", with: @fs_focus_item.start_date
    fill_in "Team", with: @fs_focus_item.team
    click_on "Create Fs focus item"

    assert_text "Fs focus item was successfully created"
    click_on "Back"
  end

  test "updating a Fs focus item" do
    visit fs_focus_items_url
    click_on "Edit", match: :first

    fill_in "Customer", with: @fs_focus_item.customer
    fill_in "End date", with: @fs_focus_item.end_date
    fill_in "Part code", with: @fs_focus_item.part_code
    fill_in "Part desc", with: @fs_focus_item.part_desc
    fill_in "Rep", with: @fs_focus_item.rep
    fill_in "Start date", with: @fs_focus_item.start_date
    fill_in "Team", with: @fs_focus_item.team
    click_on "Update Fs focus item"

    assert_text "Fs focus item was successfully updated"
    click_on "Back"
  end

  test "destroying a Fs focus item" do
    visit fs_focus_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Fs focus item was successfully destroyed"
  end
end
