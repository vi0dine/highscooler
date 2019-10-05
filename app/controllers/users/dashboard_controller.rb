# frozen_string_literal: true

module Users
  class DashboardController < ApplicationController
    def show
      @user = User.eager_load(:matura_results, :field_details).find(params[:id])
      authorize! :read, @user
      @fields = @user.field_details
      @formulas = @user.formulas
      @results = @user.results unless RecrutationPointsCalculator.call(@user)

      @study_interest = StudyInterest.new
      @matura_result = MaturaResult.new
    end
  end
end
