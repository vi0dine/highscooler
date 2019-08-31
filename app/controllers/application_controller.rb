# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    I18n.locale = :pl
  end

  protected

  def after_sign_in_path_for(resource)
    dashboard_path(resource.id)
  end

  def after_sign_out_path_for
    root_path
  end
end
