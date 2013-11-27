class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    I18n.locale = extract_locale_from_subdomain || I18n.default_locale
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first
    if parsed_locale # i.e. if there's a subdomain en, fr, etc.
      parsed_locale = parsed_locale.to_sym
      I18n.available_locales.include?(parsed_locale) ? parsed_locale : nil # e.g. return fr if fr is in available_locales; otherwise fall back on default
    end
  end
end
