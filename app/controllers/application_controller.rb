class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = :pl
  end
end
