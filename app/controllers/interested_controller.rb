# frozen_string_literal: true

class InterestedController < ApplicationController
  def create
    interest = Interested.new(interested_params)
    authorize! :create, interest
    if interest.save
      flash[:notice] = 'Dodano Cię do listy zainteresowanych'
    else
      flash[:alert] = 'Coś poszło nie tak'
    end
    redirect_to dashboard_path
  end

  private

  def interested_params
    params.require(:interested).permit(:user_id, :field_detail_id)
  end
end
