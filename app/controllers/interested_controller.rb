# frozen_string_literal: true

class InterestedController < ApplicationController
  def create
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
