# frozen_string_literal: true

class HomepageController < ApplicationController
  def index
    redirect_to dashboard_path(current_user.id) if current_user
  end
end
