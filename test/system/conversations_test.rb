require "application_system_test_case"

class ConversationsTest < ApplicationSystemTestCase
  setup do
    @conversation = conversations(:one)
  end

  test "visiting the index" do
    visit conversations_url
    assert_selector "h1", text: "Conversations"
  end

  test "should create conversation" do
    visit conversations_url
    click_on "New conversation"

    fill_in "Audio path", with: @conversation.audio_path
    fill_in "Automatic title topic", with: @conversation.automatic_title_topic
    fill_in "Conversation", with: @conversation.conversation
    fill_in "Custom topic", with: @conversation.custom_topic
    check "Enable audio" if @conversation.enable_audio
    fill_in "Language 1", with: @conversation.language_1
    fill_in "Language 2", with: @conversation.language_2
    fill_in "Level number", with: @conversation.level_number
    fill_in "Tokens conversation", with: @conversation.tokens_conversation
    click_on "Create Conversation"

    assert_text "Conversation was successfully created"
    click_on "Back"
  end

  test "should update Conversation" do
    visit conversation_url(@conversation)
    click_on "Edit this conversation", match: :first

    fill_in "Audio path", with: @conversation.audio_path
    fill_in "Automatic title topic", with: @conversation.automatic_title_topic
    fill_in "Conversation", with: @conversation.conversation
    fill_in "Custom topic", with: @conversation.custom_topic
    check "Enable audio" if @conversation.enable_audio
    fill_in "Language 1", with: @conversation.language_1
    fill_in "Language 2", with: @conversation.language_2
    fill_in "Level number", with: @conversation.level_number
    fill_in "Tokens conversation", with: @conversation.tokens_conversation
    click_on "Update Conversation"

    assert_text "Conversation was successfully updated"
    click_on "Back"
  end

  test "should destroy Conversation" do
    visit conversation_url(@conversation)
    click_on "Destroy this conversation", match: :first

    assert_text "Conversation was successfully destroyed"
  end
end
