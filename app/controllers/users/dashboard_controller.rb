# frozen_string_literal: true

module Users
  class DashboardController < ApplicationController
    def show
      @user = User.find(params[:id])
      @fields = @user.field_details
      @formulas = @user.formulas
      @results = @user.results unless RecrutationPointsCalculator.call(@user)
      authorize! :read, @user
    end

    def create_interest
      interest = Interested.new(interested_params)
      if interest.save
        flash[:notice] = 'Dodano Cię do listy zainteresowanych'
        redirect_to dashboard_path
      else
        render 'show'
      end
    end

    private

    def interested_params
      params.require(:interested).permit(:user_id, :field_detail_id)
    end
  end
end
