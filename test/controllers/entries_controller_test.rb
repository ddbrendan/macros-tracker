require "test_helper"

class EntriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get entries_url
    assert_response :success
  end

  test "should get new" do
    get new_entry_url
    assert_response :success
  end

  test "should create entry" do
    assert_difference('Entry.count') do
      post entries_url, params: { entry: { food_name: "Test Food", grams: 100.0, date: Date.current, custom_calories_per_100g: 100.0, custom_carbs_per_100g: 10.0, custom_protein_per_100g: 5.0, custom_fats_per_100g: 2.0 } }
    end
    assert_redirected_to root_path
  end

  test "should destroy entry" do
    entry = entries(:one)
    assert_difference('Entry.count', -1) do
      delete entry_url(entry)
    end
    assert_redirected_to root_path
  end
end
