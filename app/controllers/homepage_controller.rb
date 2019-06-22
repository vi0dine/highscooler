# frozen_string_literal: true

class HomepageController < ApplicationController
  def index
    if user_signed_in?
      redirect_to dashboard_path(current_user.id)
    end
  end
end
