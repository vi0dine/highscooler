# frozen_string_literal: true

class FieldOpinionsController < ApplicationController
  def create
    @field_opinion = FieldOpinion.new(field_opinion_params)
    authorize! :create, @field_opinion
    if @field_opinion.save
      flash[:notice] = 'Opinia została dodana.'
    else
      flash[:alert] = 'Wystąpił błąd podczas dodawania opinii'
    end
    redirect_to field_path(@field_opinion.field_of_study_id)
  end

  private

  def field_opinion_params
    params.require(:field_opinion).permit(:body, :is_positive, :user_id, :field_of_study_id, :academy_id)
  end
end
