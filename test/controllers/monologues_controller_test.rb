require "test_helper"

class MonologuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @monologue = monologues(:one)
  end

  test "should get index" do
    get monologues_url
    assert_response :success
  end

  test "should get new" do
    get new_monologue_url
    assert_response :success
  end

  test "should create monologue" do
    assert_difference("Monologue.count") do
      post monologues_url, params: { monologue: { audio_path: @monologue.audio_path, automatic_title_topic: @monologue.automatic_title_topic, custom_topic: @monologue.custom_topic, enable_audio: @monologue.enable_audio, language_1: @monologue.language_1, language_2: @monologue.language_2, level_number: @monologue.level_number, monologue: @monologue.monologue, tokens_monologue: @monologue.tokens_monologue } }
    end

    assert_redirected_to monologue_url(Monologue.last)
  end

  test "should show monologue" do
    get monologue_url(@monologue)
    assert_response :success
  end

  test "should get edit" do
    get edit_monologue_url(@monologue)
    assert_response :success
  end

  test "should update monologue" do
    patch monologue_url(@monologue), params: { monologue: { audio_path: @monologue.audio_path, automatic_title_topic: @monologue.automatic_title_topic, custom_topic: @monologue.custom_topic, enable_audio: @monologue.enable_audio, language_1: @monologue.language_1, language_2: @monologue.language_2, level_number: @monologue.level_number, monologue: @monologue.monologue, tokens_monologue: @monologue.tokens_monologue } }
    assert_redirected_to monologue_url(@monologue)
  end

  test "should destroy monologue" do
    assert_difference("Monologue.count", -1) do
      delete monologue_url(@monologue)
    end

    assert_redirected_to monologues_url
  end
end
