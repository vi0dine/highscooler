# frozen_string_literal: true

class AcademyOpinionsController < ApplicationController
  def create
    @academy_opinion = AcademyOpinion.new(academy_opinion_params)
    authorize! :create, @academy_opinion
    if @academy_opinion.save
      flash[:notice] = 'Opinia została dodana.'
    else
      flash[:alert] = 'Wystąpił błąd podczas dodawania opinii'
    end
    redirect_to academy_path(@academy_opinion.academy_id)
  end

  private

  def academy_opinion_params
    params.require(:academy_opinion).permit(:body, :is_positive, :academy_id, :user_id)
  end
end
