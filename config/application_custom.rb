module Consul
  class Application < Rails::Application
    config.i18n.default_locale = 'sl-SI'
    available_locales = %w(ar de en es fa fr gl he it nl pl pt-BR sq sv val zh-CN zh-TW sl-SI sl)
    config.i18n.available_locales = available_locales
    config.i18n.fallbacks = {
      'fr' => 'es',
      'gl' => 'es',
      'it' => 'es',
      'pt-BR' => 'es',
      'sl' => 'sl-SI'
    }
  end
end
