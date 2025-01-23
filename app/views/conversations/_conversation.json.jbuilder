json.extract! conversation, :id, :language_1, :language_2, :level_number, :enable_audio, :conversation, :audio_path, :tokens_conversation, :custom_topic, :automatic_title_topic, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
