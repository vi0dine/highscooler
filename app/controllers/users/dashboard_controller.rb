# frozen_string_literal: true

module Users
  class DashboardController < ApplicationController
    def show
      @user = User.find(params[:id])
      authorize! :read, @user
      @fields = @user.field_details
      @formulas = @user.formulas
      @results = @user.results unless RecrutationPointsCalculator.call(@user)
    end
  end
end
