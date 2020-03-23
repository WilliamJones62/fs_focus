require 'test_helper'

class FsFocusItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fs_focus_item = fs_focus_items(:one)
  end

  test "should get index" do
    get fs_focus_items_url
    assert_response :success
  end

  test "should get new" do
    get new_fs_focus_item_url
    assert_response :success
  end

  test "should create fs_focus_item" do
    assert_difference('FsFocusItem.count') do
      post fs_focus_items_url, params: { fs_focus_item: { customer: @fs_focus_item.customer, end_date: @fs_focus_item.end_date, part_code: @fs_focus_item.part_code, part_desc: @fs_focus_item.part_desc, rep: @fs_focus_item.rep, start_date: @fs_focus_item.start_date, team: @fs_focus_item.team } }
    end

    assert_redirected_to fs_focus_item_url(FsFocusItem.last)
  end

  test "should show fs_focus_item" do
    get fs_focus_item_url(@fs_focus_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_fs_focus_item_url(@fs_focus_item)
    assert_response :success
  end

  test "should update fs_focus_item" do
    patch fs_focus_item_url(@fs_focus_item), params: { fs_focus_item: { customer: @fs_focus_item.customer, end_date: @fs_focus_item.end_date, part_code: @fs_focus_item.part_code, part_desc: @fs_focus_item.part_desc, rep: @fs_focus_item.rep, start_date: @fs_focus_item.start_date, team: @fs_focus_item.team } }
    assert_redirected_to fs_focus_item_url(@fs_focus_item)
  end

  test "should destroy fs_focus_item" do
    assert_difference('FsFocusItem.count', -1) do
      delete fs_focus_item_url(@fs_focus_item)
    end

    assert_redirected_to fs_focus_items_url
  end
end
