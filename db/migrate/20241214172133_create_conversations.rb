class CreateConversations < ActiveRecord::Migration[8.0]
  def change
    create_table :conversations do |t|
      t.integer :language_1
      t.integer :language_2
      t.integer :level_number
      t.boolean :enable_audio
      t.jsonb :conversation
      t.text :audio_path
      t.integer :tokens_conversation
      t.text :custom_topic
      t.text :automatic_title_topic

      t.timestamps
    end
  end
end
