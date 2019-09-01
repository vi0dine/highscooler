# frozen_string_literal: true

class FieldsController < ApplicationController
  def index
    @all_fields = FieldOfStudy.all
    @fields = FieldOfStudy.order(:name).page params[:page]
  end

  def show
    @field = FieldOfStudy.find(params[:id])
    @field_opinion = FieldOpinion.new
  end

  def new
    @field_of_study = FieldOfStudy.new
    authorize! :create, @field
  end

  def create
    @field_of_study = FieldOfStudy.new(field_of_study_params)
    if @field_of_study.save
      flash[:notice] = 'Kierunek został utworzony'
      redirect_to root_path
    else
      render 'new_field'
    end
    authorize! :create, @field_of_study
  end

  private

  def field_of_study_params
    params.require(:field_of_study).permit(:name, :field_type)
  end
end
