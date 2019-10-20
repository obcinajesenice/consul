require_dependency Rails.root.join('app', 'controllers', 'admin', 'site_customization', 'information_texts_controller').to_s

class Admin::SiteCustomization::InformationTextsController < Admin::SiteCustomization::BaseController

  def update
    content_params.each do |content|
      values = content[:values].slice(*translation_params)

      unless values.empty?
        values.each do |key, value|
          locale = key.split('_').last

          if value == t(content[:id], locale: locale) || value.match(/translation missing/)
            text = I18nContent.find_or_create_by(key: content[:id])
            if text
              Globalize.locale = locale
              text.update(value: value)
            end
            next
          else
            text = I18nContent.find_or_create_by(key: content[:id])
            Globalize.locale = locale
            text.update(value: value)
          end
        end
      end

    end

    redirect_to admin_site_customization_information_texts_path,
                notice: t('flash.actions.update.translation')
  end

end
