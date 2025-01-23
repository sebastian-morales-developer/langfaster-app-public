class CreateMonologues < ActiveRecord::Migration[8.0]
  def change
    create_table :monologues do |t|
      t.integer :language_1
      t.integer :language_2
      t.integer :level_number
      t.boolean :enable_audio
      t.jsonb :monologue
      t.text :audio_path
      t.integer :tokens_monologue
      t.text :custom_topic
      t.text :automatic_title_topic

      t.timestamps
    end
  end
end
