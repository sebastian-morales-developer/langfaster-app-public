module ApplicationHelper
    def list_images_prompted
        arr = Dir.glob(Rails.root.join('public/images/prompts', '*')).map { |file| File.basename(file) }
        arr[rand(arr.size)]    
    end

    def index_conversations_image
        "/images/index/conversations.jpg"
    end

    def index_monologues_image
        "/images/index/monologues.jpg"
    end

    def languages_name_code
        [
            ['English (English)', 'en'],
            ['Español (Spanish)', 'es'],
            ['Français (French)', 'fr'],
            ['Português (Portuguese)', 'pt'],
            ['Deutsch (German)', 'de'],
            ['Nederlands (Dutch)', 'nl'],
            ['Italiano (Italian)', 'it'],
            ['Euskara (Basque)', 'ba'],            
            ['Català (Catalan)', 'ca'],
            ['Galego (Galician)', 'gl'],
            ['Polski (Polish)', 'pl'],
            ['Svenska (Swedish)', 'sv'],
            ['Dansk (Danish)', 'da'],
            ['Norsk (Norwegian)', 'nr'],
            ['Suomi (Finnish)', 'fi'],
            ['Magyar (Hungarian)', 'hu'],
            ['Čeština (Czech)', 'cs'],
            ['Slovenčina (Slovak)', 'sk'],
            ['Română (Romanian)', 'ro'],
            ['Български (Bulgarian)', 'bg'],
            ['Hrvatski (Croatian)', 'hr'],
            ['Српски (Serbian)', 'sr'],
            ['Bosanski (Bosnian)', 'bs'],
            ['Eesti (Estonian)', 'et'],
            ['Latviešu (Latvian)', 'lv'],
            ['Lietuvių (Lithuanian)', 'lt'],
            ['Ελληνικά (Greek)', 'el'],
            ['עברית (Hebrew)', 'he'],
            ['العربية (Arabic)', 'ar'],
            ['Türkçe (Turkish)', 'tr'],
            ['ไทย (Thai)', 'th'],
            ['Русский (Russian)', 'ru'],
            ['Українська (Ukrainian)', 'uk'],
            ['فارسی (Persian)', 'fa'],
            ['Kiswahili (Swahili)', 'sw'],
            ['हिन्दी (Hindi)', 'hi'],
            ['தமிழ் (Tamil)', 'ta'],
            ['Bahasa Indonesia (Indonesian)', 'id'],
            ['Tiếng Việt (Vietnamese)', 'vi'],
            ['中文 (Chinese)', 'zh'],
            ['한국어 (Korean)', 'ko'],
            ['日本語 (Japanese)', 'ja'],
            ['Bahasa Melayu (Malay)', 'ms'],
            ['Azərbaycanca (Azerbaijani)', 'az'],
            ['Հայերեն (Armenian)', 'hy'],
            ['Қазақ (Kazakh)', 'kk'],
            ['Македонски (Macedonian)', 'mk'],
            ['Māori (Maori)', 'mi'],
            ['नेपाली (Nepali)', 'ne'],
            ['Íslenska (Icelandic)', 'is'],
            ['Afrikaans (Afrikaans)', 'af'],
            ['Tagalog (Tagalog)', 'tl'],
            ['ಕನ್ನಡ (Kannada)', 'kn'],
            ['मराठी (Marathi)', 'mr'],
            ['Slovenščina (Slovenian)', 'sl'],
            ['Cymraeg (Welsh)', 'cy'],
            ['Беларуская (Belarusian)', 'be'],
            ['اردو (Urdu)', 'ur']
        ]
    end

    def title_navbar
        "LangFaster 快语"
    end

    def logo_nav_bar
        "/langfaster_logo.jpg"
    end

end
