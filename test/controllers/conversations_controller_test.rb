require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @conversation = conversations(:one)
  end

  test "should get index" do
    get conversations_url
    assert_response :success
  end

  test "should get new" do
    get new_conversation_url
    assert_response :success
  end

  test "should create conversation" do
    assert_difference("Conversation.count") do
      post conversations_url, params: { conversation: { audio_path: @conversation.audio_path, automatic_title_topic: @conversation.automatic_title_topic, conversation: @conversation.conversation, custom_topic: @conversation.custom_topic, enable_audio: @conversation.enable_audio, language_1: @conversation.language_1, language_2: @conversation.language_2, level_number: @conversation.level_number, tokens_conversation: @conversation.tokens_conversation } }
    end

    assert_redirected_to conversation_url(Conversation.last)
  end

  test "should show conversation" do
    get conversation_url(@conversation)
    assert_response :success
  end

  test "should get edit" do
    get edit_conversation_url(@conversation)
    assert_response :success
  end

  test "should update conversation" do
    patch conversation_url(@conversation), params: { conversation: { audio_path: @conversation.audio_path, automatic_title_topic: @conversation.automatic_title_topic, conversation: @conversation.conversation, custom_topic: @conversation.custom_topic, enable_audio: @conversation.enable_audio, language_1: @conversation.language_1, language_2: @conversation.language_2, level_number: @conversation.level_number, tokens_conversation: @conversation.tokens_conversation } }
    assert_redirected_to conversation_url(@conversation)
  end

  test "should destroy conversation" do
    assert_difference("Conversation.count", -1) do
      delete conversation_url(@conversation)
    end

    assert_redirected_to conversations_url
  end
end
