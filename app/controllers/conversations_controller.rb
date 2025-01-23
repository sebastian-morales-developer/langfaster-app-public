class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[ show edit update destroy ]

  # GET /conversations or /conversations.json
  def index
    @conversation = Conversation.new
    @conversations = Conversation.all
  end

  # GET /conversations/1 or /conversations/1.json
  def show
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
    @conversations = Conversation.all
  end

  # GET /conversations/1/edit
  def edit
  end

  def create
    # Fetch parameters from the form
    @conversation = Conversation.new

    @conversation.language_1 = conversation_params[:language_1]
    @conversation.language_2 = conversation_params[:language_2]
    @conversation.level_number = conversation_params[:level_number]
    @conversation.custom_topic = conversation_params[:custom_topic]
    
    # Call the private method to process input and get output objects
    output_objects = conversation_creator(conversation_params)

    # Assign output objects to the conversation instance
    
    
    
    @conversation.conversation = output_objects[:conversation]
    @conversation.audio_path = output_objects[:audio_path]
    @conversation.tokens_conversation = output_objects[:tokens_conversation]
    @conversation.automatic_title_topic = output_objects[:automatic_title_topic]
    
    

    if @conversation.save
      redirect_to @conversation, notice: 'Conversation was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /conversations/1 or /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: "Conversation was successfully updated." }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1 or /conversations/1.json
  def destroy
    @conversation.destroy!

    respond_to do |format|
      format.html { redirect_to conversations_path, status: :see_other, notice: "Conversation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def conversation_params
      #params.expect(conversation: [ :language_1, :language_2, :level_number, :enable_image, :enable_audio, :conversation, :audio_path, :tokens_conversation, :custom_topic, :automatic_title_topic ])
      params.require(:conversation).permit(
        :language_1,
        :language_2,        
        :level_number,
        :custom_topic,
        :enable_audio,
        :enable_audio_language_1,
        :enable_audio_language_2        
      )
    end

    # Morani methods

    def conversation_creator(input_params)
      # Process the input parameters and generate output objects
      # Replace this mock implementation with your actual logic

      #language_name_array = ["English", "Spanish", "French"]
      language_name_array = I18n.t('language_options').invert        
      #level_array = ["A1 (Beginner)", "A2 (Elementary)", "B1 (Intermediate)", "B2 (Upper Intermediate)", "C1 (Advanced)", "C2 (Proficiency)"]
      level_array = I18n.t('language_learning_levels').invert     
      
      language_1 = language_name_array[input_params[:language_1].to_i]
      language_2 = language_name_array[input_params[:language_2].to_i]
      level = level_array[input_params[:level_number].to_i]   
      
      
      jsonStructureDialogueScriptString = '
          {   
              "language_1": "Spanish",
              "language_2": "English", 
              "conversation_level_in_language_1": "Nivel de conversación: A1 Principiante. Español - Inglés.",
              "conversation_level_in_language_2": "Conversation level: A1 Beginner. Spanish - English.", 
                          
              "dialog": [
                {
                  "speaker": "Narrator",
                  "voice": "alloy",
                  "dialogue_language_1": "Conociendo gente nueva",
                  "dialogue_language_2": "Meeting new people.",
                  "dialogue_language_2_in_ipa": "/ˈmiːtɪŋ nuː ˈpiːpl/",
                  "dialogue_language_2_as_language_1": "Míting nù pípl."
                },
                {
                  "speaker": "Juan",
                  "voice": "onyx",
                  "dialogue_language_1": "¡Hola! ¿Cómo te llamas?",
                  "dialogue_language_2": "Hi! What is your name?",
                  "dialogue_language_2_in_ipa": "/haɪ wɒt ɪz jɔːr neɪm/",
                  "dialogue_language_2_as_language_1": "Jai! Juat is yor néim?"
                },
                {
                  "speaker": "Ana",
                  "voice": "nova",
                  "dialogue_language_1": "Me llamo Ana. ¿Y tú?",
                  "dialogue_language_2": "My name is Ana. And you?",
                  "dialogue_language_2_in_ipa": "/maɪ neɪm ɪz ˈænə ənd juː/",
                  "dialogue_language_2_as_language_1": "Mai néim is Ána. Ánd iú?"
                },
                {
                  "speaker": "Juan",
                  "voice": "onyx",
                  "dialogue_language_1": "Me llamo Juan. ¿De dónde eres?",
                  "dialogue_language_2": "My name is Juan. Where are you from?",
                  "dialogue_language_2_in_ipa": "/maɪ neɪm ɪz hwɑːn wɛr ɑːr juː frɒm/",
                  "dialogue_language_2_as_language_1": "Mai néim is Juán. Wér ár iú fróm?"
                },
                {
                  "speaker": "Ana",
                  "voice": "nova",
                  "dialogue_language_1": "Soy de México. ¿Y tú?",
                  "dialogue_language_2": "I am from Mexico. And you?",
                  "dialogue_language_2_in_ipa": "/aɪ æm frɒm ˈmɛksɪkəʊ ənd juː/",
                  "dialogue_language_2_as_language_1": "Ái am fróm Méksicou. Ánd iú?"
                },
                {
                  "speaker": "Juan",
                  "voice": "onyx",
                  "dialogue_language_1": "Soy de España.",
                  "dialogue_language_2": "I am from Spain.",
                  "dialogue_language_2_in_ipa": "/aɪ æm frɒm speɪn/",
                  "dialogue_language_2_as_language_1": "Ái am fróm Spein."
                },
                {
                  "speaker": "Ana",
                  "voice": "nova",
                  "dialogue_language_1": "¡Qué interesante!",
                  "dialogue_language_2": "How interesting!",
                  "dialogue_language_2_in_ipa": "/haʊ ˈɪntrəstɪŋ/",
                  "dialogue_language_2_as_language_1": "Jaú íntrésting!"
                },
                {
                  "speaker": "Juan",
                  "voice": "onyx",
                  "dialogue_language_1": "Sí, me gusta España.",
                  "dialogue_language_2": "Yes, I like Spain.",
                  "dialogue_language_2_in_ipa": "/jɛs aɪ laɪk speɪn/",
                  "dialogue_language_2_as_language_1": "Iés, Ái láik Spein."
                },
                {
                  "speaker": "Ana",
                  "voice": "nova",
                  "dialogue_language_1": "¿Te gusta la comida española?",
                  "dialogue_language_2": "Do you like Spanish food?",
                  "dialogue_language_2_in_ipa": "/duː juː laɪk ˈspænɪʃ fuːd/",
                  "dialogue_language_2_as_language_1": "Dú iú láik Spánish fúd?"
                },
                {
                  "speaker": "Juan",
                  "voice": "onyx",
                  "dialogue_language_1": "Sí, me encanta.",
                  "dialogue_language_2": "Yes, I love it.",
                  "dialogue_language_2_in_ipa": "/jɛs aɪ lʌv ɪt/",
                  "dialogue_language_2_as_language_1": "Iés, Ái lób it."
                },
                {
                  "speaker": "Ana",
                  "voice": "nova",
                  "dialogue_language_1": "¡Genial!",
                  "dialogue_language_2": "Great!",
                  "dialogue_language_2_in_ipa": "/ɡreɪt/",
                  "dialogue_language_2_as_language_1": "Greit!"
                },
                {
                  "speaker": "Juan",
                  "voice": "onyx",
                  "dialogue_language_1": "Bueno, tengo que irme. ¡Hasta luego!",
                  "dialogue_language_2": "Well, I have to go. See you later!",
                  "dialogue_language_2_in_ipa": "/wɛl aɪ hæv tuː ɡoʊ siː juː ˈleɪtər/",
                  "dialogue_language_2_as_language_1": "Wél, Ái jæv tú góu. Sí iú léitér."
                },
                {
                  "speaker": "Ana",
                  "voice": "nova",
                  "dialogue_language_1": "¡Hasta luego, Juan!",
                  "dialogue_language_2": "See you later, Juan!",
                  "dialogue_language_2_in_ipa": "/siː juː ˈleɪtər hwɑːn/",
                  "dialogue_language_2_as_language_1": "Sí iú léitér Juán."
                }
              ],
              
          }
      '
      
      prompt = "
        Write a conversation between two people using JSON script format.
        The conversation must have the next technical parameters, delimited by $$:
        $
        - The conversation level must be  #{level} according to the Common European Framework of Reference for Languages (CEFR).
        - The conversation topic must be about #{input_params[:custom_topic]}.
        - The conversation must include a dialogue between 3 speakers: one of them is the Narrator speaker. The remaining two are the conversation's characters. 
        - The conversation will be wroten in two languages: 'language_1' is '#{language_1}', and 'language_2' is '#{language_2}'.
        $

        1. Narrator’s Role:

        * The first conversation dialog block contains a title, in both languages, that summarizes the context of the conversation that will be created.

        2. Speakers:

        * Make sure that the conversation recreates a real scene between two people, inside the technical parameters enounced previously.
        * Each character’s dialogue should include one of the next six voices with their respective male or female tone: alloy (male), echo (male), fable (female), onyx (male), nova (female), and shimmer (female). Each character’s dialogue has assigned an unique voice.
        * Don't name the speakers like next: alloy, echo, fable, onyx, nova, and shimmer. These terms are reserved ONLY FOR the voice's attributes. Create new names.

        3. Structure:

        * Use JSON format to organize the conversation. 
        * Each line of dialogue should include the next elements (the text delimited by %% explains the structure elements):
        - The speaker’s name (speaker)
        - The dialogue in language 1 (dialogue_language_1).
        - The dialogue in language 2 (dialogue_language_2).
        - The dialogue in language 2 (dialogue_language_2_in_ipa) wroten using the International Phonetic Alphabet (IPA) system.
        - The dialogue in language 2 (dialogue_language_2_as_language_1) wroten using the characters and pronunciation of 'language_1'. Don't use IPA system characters here. Only use the characters used on the alphabet of 'language_1'. 
        * At the first stage of the JSON script, you must include the 'language_1' and 'language_2' selected. Also, must include the 'conversation_level_in_language_1' and 'conversation_level_in_language_2', according to the CERF level, and should include the name of both languages, wroten in the corresponding language translation. The text delimited by %% explains the JSON structure example.  
        * Only the first line of dialogue should include the Narrator’s dialogue telling the conversation's title, translated in the both languages selected. 
        * The conversation should clearly be built under the technical parameters explained in the delimited text by $$ and %%.

        4. JSON structure example:

        The next text delimited by %% is a JSON example structure that explains better the previous instructions that follows the desired answer.
        In this case example delimited by %%, the user has chosen 'language_1' as 'Spanish' and 'language_2' as 'English'. Also, has chosen the conversation level as 'A1 (Beginner)'. 
        Your final answer should be around the next parameters: 'language_1' is '#{language_1}', 'language_2' is '#{language_2}', and conversation level is '#{level}'.

        %
        #{jsonStructureDialogueScriptString}
        %
      "
       
      response = chatgpt_response(prompt, true)
      conversation = JSON.parse(response.dig("choices", 0, "message", "content").strip)
      usage = response.dig("usage")
      tokens_conversation = usage["total_tokens"] if usage
      automatic_title_topic = conversation["dialog"][0]["dialogue_language_1"]
      conversation["dialog"][0]["dialogue_language_1"] = "#{conversation["dialog"][0]["dialogue_language_1"]} _ #{conversation["conversation_level_in_language_1"]}" 
      conversation["dialog"][0]["dialogue_language_2"] = "#{conversation["dialog"][0]["dialogue_language_2"]} _ #{conversation["conversation_level_in_language_2"]}" 
      enable_audio = input_params[:enable_audio]

      if enable_audio == "1"
        enable_audio = true
      elsif enable_audio == "0"
        enable_audio = false
      end

      enable_audio_language_1 = input_params[:enable_audio_language_1]
      enable_audio_language_2 = input_params[:enable_audio_language_2]

      if enable_audio_language_1 == "1"
        enable_audio_language_1 = true
      elsif enable_audio_language_1 == "0"
        enable_audio_language_1 = false
      end

      if enable_audio_language_2 == "1"
        enable_audio_language_2 = true
      elsif enable_audio_language_2 == "0"
        enable_audio_language_2 = false
      end
      
      if !enable_audio_language_1 && !enable_audio_language_2
        enable_audio = false
      else
        enable_audio = true
      end

      puts "enable_audio for conversations?: #{enable_audio}"
      puts "enable_audio_language_1 for conversations?: #{enable_audio_language_1}"
      puts "enable_audio_language_2 for conversations?: #{enable_audio_language_2}"
      
      if enable_audio == true
        puts "enable_audio for conversations YES!"
        # Call the generate_audio method to create and save the audio
        conversation, audio_path = generate_audio_multivoice_conversations_json(conversation, enable_audio_language_1, enable_audio_language_2) # USD$0.02 per audio
      end

      # Mock output objects
      output_objects = {
          conversation: conversation,                  # JSONB field
          audio_path: audio_path,            # Text
          tokens_conversation: tokens_conversation,                      # Integer
          automatic_title_topic: automatic_title_topic,
         
      }

      # Return the output objects
      output_objects
    end
end
