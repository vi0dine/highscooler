class FieldsController < ApplicationController
  def index
    @all_fields = FieldOfStudy.all
    @fields = FieldOfStudy.order(:name).page params[:page]
  end

  def show
    @field = FieldOfStudy.find(params[:id])
  end

  def new_field
    @field_of_study = FieldOfStudy.new
    authorize! :create, @field
  end

  def create_field
    authorize! :create, @field
    @field_of_study = FieldOfStudy.new(field_of_study_params)
    if @field_of_study.save
      flash[:notice] = 'Kierunek został utworzony'
      redirect_to root_path
    else
      render 'new_field'
    end
  end

  def new_details
    @field_details = FieldDetail.new
    authorize! :create, @field_details
  end

  def create_details
    authorize! :create, @field_details
    @field_details = FieldDetail.new(field_details_params)
    if @field_details.save
      flash[:notice] = 'Kierunek został dodany do uczelni'
      redirect_to root_path
    else
      render 'new_details'
    end
  end

  private

  def field_of_study_params
    params.require(:field_of_study).permit(:name, :field_type)
  end

  def field_details_params
    params.require(:field_details).permit(:academy_id, :field_of_study_id, :students_limit, :recrutation_formula, :minimal_points)
  end
end
