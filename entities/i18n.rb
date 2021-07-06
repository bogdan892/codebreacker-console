# frozen_string_literal: true

# I18n.load_path << Dir["#{File.expand_path("../config/locales")}/*.yml"]
# I18n.load_path << Dir["#{File.expand_path('../config/locales')}/*.yml"]
I18n.load_path += Dir[File.expand_path('../config/locales/*.yml', __dir__)]
I18n.config.available_locales = :en
# I18n.default_locale = :en
