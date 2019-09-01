# frozen_string_literal: true

class FieldDetailsController < ApplicationController
  def new
    @field_detail = FieldDetail.new
    authorize! :create, @field_detail
  end

  def create
    @field_detail = FieldDetail.new(field_detail_params)
    if @field_detail.save
      flash[:notice] = 'Kierunek został dodany do uczelni'
      redirect_to root_path
    else
      render 'new_detail'
    end
    authorize! :create, @field_detail
  end

  private

  def field_detail_params
    params.require(:field_detail).permit(:academy_id, :field_of_study_id, :students_limit, :recrutation_formula, :minimal_points)
  end
end
