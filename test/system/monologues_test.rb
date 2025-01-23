require "application_system_test_case"

class MonologuesTest < ApplicationSystemTestCase
  setup do
    @monologue = monologues(:one)
  end

  test "visiting the index" do
    visit monologues_url
    assert_selector "h1", text: "Monologues"
  end

  test "should create monologue" do
    visit monologues_url
    click_on "New monologue"

    fill_in "Audio path", with: @monologue.audio_path
    fill_in "Automatic title topic", with: @monologue.automatic_title_topic
    fill_in "Custom topic", with: @monologue.custom_topic
    check "Enable audio" if @monologue.enable_audio
    fill_in "Language 1", with: @monologue.language_1
    fill_in "Language 2", with: @monologue.language_2
    fill_in "Level number", with: @monologue.level_number
    fill_in "Monologue", with: @monologue.monologue
    fill_in "Tokens monologue", with: @monologue.tokens_monologue
    click_on "Create Monologue"

    assert_text "Monologue was successfully created"
    click_on "Back"
  end

  test "should update Monologue" do
    visit monologue_url(@monologue)
    click_on "Edit this monologue", match: :first

    fill_in "Audio path", with: @monologue.audio_path
    fill_in "Automatic title topic", with: @monologue.automatic_title_topic
    fill_in "Custom topic", with: @monologue.custom_topic
    check "Enable audio" if @monologue.enable_audio
    fill_in "Language 1", with: @monologue.language_1
    fill_in "Language 2", with: @monologue.language_2
    fill_in "Level number", with: @monologue.level_number
    fill_in "Monologue", with: @monologue.monologue
    fill_in "Tokens monologue", with: @monologue.tokens_monologue
    click_on "Update Monologue"

    assert_text "Monologue was successfully updated"
    click_on "Back"
  end

  test "should destroy Monologue" do
    visit monologue_url(@monologue)
    click_on "Destroy this monologue", match: :first

    assert_text "Monologue was successfully destroyed"
  end
end
