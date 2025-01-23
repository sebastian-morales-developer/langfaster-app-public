class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def chatgpt_response(prompt, isJsonResponse)
    # Initialize the OpenAI client with your API key
    client = OpenAI::Client.new(access_token: ENV['OPENAI_API_KEY'])
    
    # Make a request to the OpenAI Chat Completion API
    if isJsonResponse      
      response = client.chat(
        parameters: {
          model: ENV['OPENAI_GPT_MODEL'],
          messages: [
            { role: "user", content: prompt }
          ],
          max_tokens: ENV['OPENAI_MAX_TOKENS'].to_i,
          temperature: ENV['OPENAI_TEMPERATURE'].to_f,
          response_format: { "type": "json_object" },
        }
      )
    else
      response = client.chat(
        parameters: {
          model: ENV['OPENAI_GPT_MODEL'],
          messages: [
            { role: "user", content: prompt }
          ],
          max_tokens: ENV['OPENAI_MAX_TOKENS'].to_i,
          temperature: ENV['OPENAI_TEMPERATURE'].to_f,
        }
      )
    end
    return response
  end

  # Define the multivoice audio method
  def generate_audio_multivoice_conversations_json(conversation, enable_audio_language_1, enable_audio_language_2)      

    string_temporary_audios = []  

    conversation["dialog"].each do |item|      
      if enable_audio_language_1 == true
        audio_path = generate_audio("#{item["dialogue_language_1"]}(\<speak\>\<break time=\"1s\"/\>\</speak\>)", item["voice"])
        string_temporary_audios << audio_path  
        item["audio1_path"] = "/audios/prompts/#{audio_path}"
      end
      if enable_audio_language_2 == true
        audio_path = generate_audio("#{item["dialogue_language_2"]}(\<speak\>\<break time=\"1s\"/\>\</speak\>)", item["voice"])                   
        string_temporary_audios << audio_path
        item["audio2_path"] = "/audios/prompts/#{audio_path}"
      end
    end

    # Create a list of mp3 files to be merged
    mp3_list_file_txt = "#{SecureRandom.uuid}.txt"
    File.open("public/audios/prompts/#{mp3_list_file_txt}", "w") do |file|
      string_temporary_audios.each { |item|
        file.puts "file '#{item}'"
      }
    end

    # Command to merge mp3 files using FFmpeg
    mp3_final = "#{SecureRandom.uuid}.mp3"
    #system("ffmpeg -f concat -safe 0 -i public/audios/prompts/#{mp3_list_file_txt} -c copy public/audios/prompts/#{mp3_final}")
    system("ffmpeg -f concat -safe 0 -i #{Rails.root}/public/audios/prompts/#{mp3_list_file_txt} -c copy #{Rails.root}/public/audios/prompts/#{mp3_final}")

    # Remove the temporary file list and silent mp3
    #string_temporary_audios.each { |item|
     # File.delete("public/audios/prompts/#{item}")
    #}
    File.delete("public/audios/prompts/#{mp3_list_file_txt}")      

    return conversation, "/audios/prompts/#{mp3_final}"

  end

  # Define the multivoice audio method
  def generate_audio_multivoice_monologues_json(monologue, enable_audio_language_1, enable_audio_language_2)      

    string_temporary_audios = []  


    #if enable_audio_language_1 == true
     # title_level_intro_language_1 = "#{monologue["title_language_1"]} - #{monologue["monologue_level_in_language_1"]}"
     # string_temporary_audios << generate_audio("#{title_level_intro_language_1}(\<speak\>\<break time=\"1s\"/\>\</speak\>)", monologue["title_voice"])  
    #end
    #if enable_audio_language_2 == true
     # title_level_intro_language_2 = "#{monologue["title_language_2"]} - #{monologue["monologue_level_in_language_2"]}"
     # string_temporary_audios << generate_audio("#{title_level_intro_language_2}(\<speak\>\<break time=\"1s\"/\>\</speak\>)", monologue["title_voice"])                  
    #end

    monologue["monologue"].each do |item|      
      if enable_audio_language_1 == true
        audio_path = generate_audio("#{item["monologue_language_1"]}(\<speak\>\<break time=\"1s\"/\>\</speak\>)", monologue["monologue_voice"])  
        string_temporary_audios << audio_path
        item["audio1_path"] = "/audios/prompts/#{audio_path}"
      end
      if enable_audio_language_2 == true
        audio_path = generate_audio("#{item["monologue_language_2"]}(\<speak\>\<break time=\"1s\"/\>\</speak\>)", monologue["monologue_voice"])                  
        string_temporary_audios << audio_path
        item["audio2_path"] = "/audios/prompts/#{audio_path}"
      end
    end

    # Create a list of mp3 files to be merged
    mp3_list_file_txt = "#{SecureRandom.uuid}.txt"
    File.open("public/audios/prompts/#{mp3_list_file_txt}", "w") do |file|
      string_temporary_audios.each { |item|
        file.puts "file '#{item}'"
      }
    end

    # Command to merge mp3 files using FFmpeg
    mp3_final = "#{SecureRandom.uuid}.mp3"
    #system("ffmpeg -f concat -safe 0 -i public/audios/prompts/#{mp3_list_file_txt} -c copy public/audios/prompts/#{mp3_final}")
    system("ffmpeg -f concat -safe 0 -i #{Rails.root}/public/audios/prompts/#{mp3_list_file_txt} -c copy #{Rails.root}/public/audios/prompts/#{mp3_final}")

    # Remove the temporary file list and silent mp3
    # string_temporary_audios.each { |item|
    #   File.delete("public/audios/prompts/#{item}")
    # }
    File.delete("public/audios/prompts/#{mp3_list_file_txt}")      

    return monologue, "/audios/prompts/#{mp3_final}"

  end

  # Define the generate_audio method
  def generate_audio(text, voice_audio)
    # Define the OpenAI Text-to-Speech API endpoint
    uri = URI.parse("https://api.openai.com/v1/audio/speech")

    # Initialize the HTTP POST request
    request = Net::HTTP::Post.new(uri)
    request["Content-Type"] = "application/json"
    request["Authorization"] = "Bearer #{ENV['OPENAI_API_KEY']}"

    # Prepare the payload
    request.body = {
      model: "tts-1",
      input: text,
      voice: voice_audio
    }.to_json

    # Execute the request
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end

    # Handle the response
    if response.is_a?(Net::HTTPSuccess)
      
      # The response body contains the audio data
      audio_data = response.body

      # Generate a unique filename for the audio file
      filename = "#{SecureRandom.uuid}.mp3"

      # Define the path to save the audio file
      audio_directory = Rails.root.join("public", "audios", "prompts")
      FileUtils.mkdir_p(audio_directory) unless Dir.exist?(audio_directory)
      audio_path = audio_directory.join(filename)
      
      # Write the audio data to the file system
      File.open(audio_path, "wb") do |file|
        file.write(audio_data)
      end        

      # Return the relative path to the audio file
      filename
      
    else
      # Log the error for debugging purposes
      Rails.logger.error "OpenAI Text-to-Speech API request failed: #{response.code} #{response.message}"
      nil
    end
  rescue StandardError => e
    # Log any unexpected errors
    Rails.logger.error "Error in generate_audio: #{e.message}"
    nil
  end

end
