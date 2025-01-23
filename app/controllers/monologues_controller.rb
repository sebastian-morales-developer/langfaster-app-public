class MonologuesController < ApplicationController
  before_action :set_monologue, only: %i[ show edit update destroy ]

  # GET /monologues or /monologues.json
  def index
    @monologues = Monologue.all
    @monologue = Monologue.new
  end

  # GET /monologues/1 or /monologues/1.json
  def show
  end

  # GET /monologues/new
  def new
    @monologue = Monologue.new
    @monologues = Monologue.all
  end

  # GET /monologues/1/edit
  def edit
  end

  # POST /monologues or /monologues.json
  def create
    # Fetch parameters from the form
    @monologue = Monologue.new

    @monologue.language_1 = monologue_params[:language_1]
    @monologue.language_2 = monologue_params[:language_2]
    @monologue.level_number = monologue_params[:level_number]
    @monologue.custom_topic = monologue_params[:custom_topic]
    
    # Call the private method to process input and get output objects
    output_objects = monologue_creator(monologue_params)

    # Assign output objects to the monologue instance
        
    
    @monologue.monologue = output_objects[:monologue]
    @monologue.audio_path = output_objects[:audio_path]
    @monologue.tokens_monologue = output_objects[:tokens_monologue]
    @monologue.automatic_title_topic = output_objects[:automatic_title_topic]
    
    

    if @monologue.save
      redirect_to @monologue, notice: 'monologue was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /monologues/1 or /monologues/1.json
  def update
    respond_to do |format|
      if @monologue.update(monologue_params)
        format.html { redirect_to @monologue, notice: "Monologue was successfully updated." }
        format.json { render :show, status: :ok, location: @monologue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @monologue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /monologues/1 or /monologues/1.json
  def destroy
    @monologue.destroy!

    respond_to do |format|
      format.html { redirect_to monologues_path, status: :see_other, notice: "Monologue was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  private


    

    # Use callbacks to share common setup or constraints between actions.
    def set_monologue
      @monologue = Monologue.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def monologue_params
      #params.expect(monologue: [ :language_1, :language_2, :level_number, :enable_audio, :monologue, :audio_path, :tokens_monologue, :custom_topic, :automatic_title_topic ])
      params.require(:monologue).permit(
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

    def monologue_creator(input_params)
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
              "title_language_1": "La importancia de la ingeniería backend en el futuro de la tecnología", 
              "title_language_2": "The importance of backend engineering in the future of technology",
              "monologue_level_in_language_1": "Nivel del monólogo: C1 Avanzado. Español - Inglés.",
              "monologue_level_in_language_2": "Monologue level: C1 Advanced. Spanish - English.", 
              "title_voice": "alloy",
              "monologue_voice": "onix",              
                          
              "monologue": [
                {
                  "monologue_language_1": "Hoy vamos a hablar de la importancia de la ingeniería backend y su papel fundamental en el futuro de la tecnología.",
                  "monologue_language_2": "Today, we are going to talk about the importance of backend engineering and its fundamental role in the future of technology.",
                  "monologue_language_2_in_ipa": "/təˈdeɪ, wi ɑːr ɡəʊɪŋ tə tɔːk əˈbaʊt ði ˈɪmpɔːtəns ʌv ˈbækˌɛnd ˌɪnˈdʒɪnɪərɪŋ ənd ɪts ˌfʌndəˈmɛntəl roʊl ɪn ðə ˈfjuːtʃər ʌv tɛkˈnɒlədʒi/",
                  "monologue_language_2_as_language_1": "Tudey, güí ar góuingu tú tók abáut de ímpórtans of báckend indyíriñg and its fándaméntal ról in de fíuchur of téknólogui."
                },
                {
                  "monologue_language_1": "La ingeniería backend se refiere a la parte del desarrollo de software que se enfoca en el lado del servidor. Es responsable de garantizar que los datos fluyan correctamente entre el servidor y el cliente.",
                  "monologue_language_2": "Backend engineering refers to the part of software development that focuses on the server side. It is responsible for ensuring that data flows properly between the server and the client.",
                  "monologue_language_2_in_ipa": "/ˈbækˌɛnd ˌɪnˈdʒɪnɪərɪŋ rɪˈfɜːrz tə ðə pɑːrt ʌv ˈsɔːftweə dɪˈvɛləpmənt ðæt ˈfəʊkəsɪz ɒn ðə ˈsɜːvə saɪd. ɪt ɪz rɪˈspɒnsəbl fɔːr ɪnˈʃʊərɪŋ ðæt ˈdeɪtə fləʊz ˈprɒpəli bɪˈtwiːn ðə ˈsɜːvə ənd ðə ˈklaɪənt/",
                  "monologue_language_2_as_language_1": "Bákend indyíriñg rífers tú de párt of sóftwér dívélohpment dát fókuses ón de sérver said. It is ríspónsabl for inchúring dát déita flóws próperli bitwín de sérver and de cláient."
                },
                {
                  "monologue_language_1": "En el futuro, la ingeniería backend será aún más esencial a medida que las empresas busquen soluciones más eficientes y escalables. A medida que los datos aumentan, el backend será clave para asegurar que todo funcione sin problemas.",
                  "monologue_language_2": "In the future, backend engineering will become even more essential as companies look for more efficient and scalable solutions. As data increases, the backend will be key to ensuring everything runs smoothly.",
                  "monologue_language_2_in_ipa": "/ɪn ðə ˈfjuːtʃər, ˈbækˌɛnd ˌɪnˈdʒɪnɪərɪŋ wɪl bɪˈkʌm ˈiːvən mɔːr ɪˈsɛnʃəl æz ˈkəmˌpæniz lʊk fɔːr mɔːr ɪˈfɪʃənt ənd ˈskeɪləbl səˈluːʃənz. æz ˈdeɪtə ɪnˈkriːsɪz, ðə ˈbækˌɛnd wɪl biː kiː tʊ ɪnˈʃʊərɪŋ ˈɛvrɪθɪŋ rʌnz ˈsmuːðli/",
                  "monologue_language_2_as_language_1": "In de fíuchur, bákend indyíriñg wil bikám ívén mór isénshál as cómpanís luk for mór ifíshent and kéileibl soluúshons. Az déita inkriisiz, de bákend wil bi kí tú inshúaring évrithing ráns smúðli."
                },
                {
                  "monologue_language_1": "La capacidad de crear aplicaciones rápidas y sin problemas dependerá en gran medida de la eficiencia del backend. Los ingenieros backend deben trabajar en la optimización de las bases de datos, el manejo de la concurrencia y la seguridad.",
                  "monologue_language_2": "The ability to create fast and seamless applications will heavily depend on the efficiency of the backend. Backend engineers need to work on optimizing databases, handling concurrency, and security.",
                  "monologue_language_2_in_ipa": "/ðə əˈbɪləti tʊ kriːeɪt fæst ənd ˈsiːmləs ˌæplɪˈkeɪʃənz wɪl ˈhɛvɪli dɪˈpɛnd ɒn ði ɪˈfɪʃənsi ʌv ðə ˈbækˌɛnd. ˈbækˌɛnd ˌɪnˈdʒɪnɪərz niːd tʊ wɜːrk ɒn ˈɒptəˌmaɪzɪŋ ˈdeɪtəˌbeɪsɪz, ˈhændlɪŋ kənˈkʌrənsɪ, ənd sɪˈkjʊərəti/",
                  "monologue_language_2_as_language_1": "De abiliti tú kriéit fást and símlés áplicaíshons wil jévilí dipénd ón di ifíshensi of de bákend. Bákend indyíriers níid tú wérk ón óptimáizing déitabeisis, jándling konkárrensi, and sikyúriti."
                },
                {
                  "monologue_language_1": "Además, el futuro de la tecnología también depende de la integración del backend con otras tecnologías emergentes, como la inteligencia artificial, el aprendizaje automático y la computación en la nube. El backend será la base para todas estas innovaciones.",
                  "monologue_language_2": "Furthermore, the future of technology also depends on the integration of the backend with other emerging technologies such as artificial intelligence, machine learning, and cloud computing. The backend will be the foundation for all of these innovations.",
                  "monologue_language_2_in_ipa": "/ˈfɜːðəˌmɔːr, ðə ˈfjuːtʃər ʌv tɛkˈnɒlədʒi ɔːlsəʊ dɪˈpɛndz ɒn ði ˌɪntɪˈɡreɪʃən ʌv ðə ˈbækˌɛnd wɪð ˈʌðə ɪˈmɜːdʒɪŋ tɛkˈnɒlədʒiz sʌʧ æz ɑːtɪˈfɪʃəl ɪnˈtɛlɪdʒəns, məˈʃiːn ˈlɜːnɪŋ, ənd klaʊd kəmˈpjuːtɪŋ. ðə ˈbækˌɛnd wɪl biː ðə faʊnˈdeɪʃən fɔːr ɔːl ʌv ðiz ˌɪnəˈveɪʃənz/",
                  "monologue_language_2_as_language_1": "Furðermór, de fíuchur of téknólogui ólsó dipénds ón di intégreishon of de bákend widh áther imérging téknóloguís sách as artífíshial inteligéns, mashín lérning, and cláud cómputing. De bákend wil bí de faundéishon for ól of díz ínnovéishons."
                },
                {
                  "monologue_language_1": "Es claro que la ingeniería backend no solo es crucial para el funcionamiento diario de las aplicaciones, sino que también será la clave para afrontar los desafíos tecnológicos del futuro.",
                  "monologue_language_2": "It is clear that backend engineering is not only crucial for the daily operation of applications, but will also be the key to addressing the technological challenges of the future.",
                  "monologue_language_2_in_ipa": "/ɪt ɪz klɪər ðət ˈbækˌɛnd ˌɪnˈdʒɪnɪərɪŋ ɪz nɒt ˈəʊnli ˈkruːʃəl fɔːr ðə ˈdeɪli ˌɒpəˈreɪʃən ʌv ˌæplɪˈkeɪʃənz, bʌt wɪl ɔːlsəʊ biː ðə kiː tʊ əˈdrɛsɪŋ ðə ˌtɛkˈnɒlədʒɪkəl ˈʧælɪndʒɪz ʌv ðə ˈfjuːtʃər/",
                  "monologue_language_2_as_language_1": "It is cliar dát bákend indyíriñg is nót ónli krúshul for de déili óperéishon of áplíkeishons, bát wil ólsó bí de kí tú adrésing de téknólogikál chálindjiz of de fíuchur."
                }

              ],
              
          }
      '
      
      prompt = "
        Write a monologue using JSON script format, where its title and each paragraph will be separated by JSON objects.
        The monologue must have the next technical parameters, delimited by $$:
        $
          - The level of writing of the monologue must be '#{level}', according to the Common European Framework of Reference for Languages (CEFR).
          - The monologue topic must be about the next text delimited by {}: {#{input_params[:custom_topic]}}.
          - The monologue will be written in two languages: 'language_1' is '#{language_1}', and 'language_2' is '#{language_2}'.
        $

        1. First JSON objects:

        * The first JSON objects should include the next information:
          - language_1: The language 1 chosen. In this case, is '#{language_1}'.
          - language_2: The language 2 chosen. In this case, is '#{language_2}'.          
          - title_language_1: According to the monologue you will write, assign a name to this monologue and write in the language 1 chosen.
          - title_language_2: Write the same previous title but in the language 2 chosen.
          - monologue_level_in_language_1: The level of writing of the monologue chosen written in language 1. In this case, '#{level}'.  
          - monologue_level_in_language_2: Write the same previous monologue level but in the language 2 chosen.
          - title_voice: choose randomly one of the next six voices selected randomly with their respective male or female tone: alloy (male), echo (male), fable (female), onyx (male), nova (female), and shimmer (female).
          - monologue_voice: choose randomly, without repeating the voice selected for title_voice, one of the next six voices selected randomly with their respective male or female tone: alloy (male), echo (male), fable (female), onyx (male), nova (female), and shimmer (female). 

        2. Monologue objects:

        * Make sure the monologue recreates a real explanation about the topic chosen, which is expressed in the text delimited by {}.
        * Each JSON object in monologue should include the next elements (the text delimited by %% explains better the JSON structure elements):
          - The monologue paragraph in language 1 (monologue_language_1). The level of writing of the monologue must be '#{level}', according to the Common European Framework of Reference for Languages (CEFR).
          - The monologue paragraph in language 2 (monologue_language_2). The level of writing of the monologue must be '#{level}', according to the Common European Framework of Reference for Languages (CEFR).
          - The monologue paragraph in language 2 (monologue_language_2_in_ipa) written using the International Phonetic Alphabet (IPA) system.
          - The monologue paragraph in language 2 (monologue_language_2_as_language_1) written using the characters and pronunciation of 'language_1'. Don't use IPA system characters here. Only use the characters used on the alphabet of 'language_1'.         

        3. JSON structure example:

        The next text delimited by %% is a JSON example structure that explains better the previous instructions that follows the desired answer.
        In this case example delimited by %%, the user has chosen 'language_1' as 'Spanish' and 'language_2' as 'English'. Also, has chosen the monologue level as 'C1 (Advanced)'. 
        Your final answer should be around the next parameters: 'language_1' is '#{language_1}', 'language_2' is '#{language_2}', and monologue writing level is '#{level}'.

        %
        #{jsonStructureDialogueScriptString}
        %
      "
       
      response = chatgpt_response(prompt, true)

      puts "***************************"
      puts "***************************"
      puts "***************************"
      puts "***************************"
      puts response
      puts "***************************"
      puts "***************************"
      puts "***************************"
      puts "***************************"
      

      monologue = JSON.parse(response.dig("choices", 0, "message", "content").strip)
      usage = response.dig("usage")
      tokens_monologue = usage["total_tokens"] if usage
      automatic_title_topic = monologue["title_language_1"]
      #automatic_title_topic = monologue["dialog"][0]["dialogue_language_1"]
      #monologue["monologue"][0]["monologue_language_1"] = "#{monologue["monologue"][0]["monologue_language_1"]} _ #{monologue["monologue_level_in_language_1"]}" 
      #monologue["monologue"][0]["monologue_language_2"] = "#{monologue["monologue"][0]["monologue_language_2"]} _ #{monologue["monologue_level_in_language_2"]}" 
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

      puts "enable_audio for monologues?: #{enable_audio}"
      puts "enable_audio_language_1 for monologues?: #{enable_audio_language_1}"
      puts "enable_audio_language_2 for monologues?: #{enable_audio_language_2}"
      
      if enable_audio == true
        puts "enable_audio for monologues YES!"
        # Call the generate_audio method to create and save the audio
        monologue, audio_path = generate_audio_multivoice_monologues_json(monologue, enable_audio_language_1, enable_audio_language_2) # USD$0.02 per audio
      end

      # Mock output objects
      output_objects = {
          monologue: monologue,                  # JSONB field
          audio_path: audio_path,            # Text
          tokens_monologue: tokens_monologue,                      # Integer
          automatic_title_topic: automatic_title_topic,
         
      }

      # Return the output objects
      output_objects
    end
end
