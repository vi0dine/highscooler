class FieldsController < ApplicationController
  def index
    @all_fields = FieldOfStudy.all
    @fields = FieldOfStudy.order(:name).page params[:page]
  end

  def show
    @field = FieldOfStudy.find(params[:id])
    @field_opinion = FieldOpinion.new
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

  def new_detail
    @field_detail = FieldDetail.new
    authorize! :create, @field_detail
  end

  def create_detail
    authorize! :create, @field_detail
    @field_detail = FieldDetail.new(field_detail_params)
    if @field_detail.save
      flash[:notice] = 'Kierunek został dodany do uczelni'
      redirect_to root_path
    else
      render 'new_detail'
    end
  end

  def create_field_opinion
    authorize! :create, @field_opinion
    @field_opinion = FieldOpinion.new(field_opinion_params)
    if @field_opinion.save
      flash[:notice] = 'Opinia została dodana. Odśwież stronę.'
      # redirect_to field_path(@field_opinion.field_of_study_id)
    else
      flash[:alert] = 'Wystąpił błąd podczas dodawania opinii'
      # redirect_to field_path(@field_opinion.field_of_study_id)
    end
  end

  private

  def field_of_study_params
    params.require(:field_of_study).permit(:name, :field_type)
  end

  def field_detail_params
    params.require(:field_detail).permit(:academy_id, :field_of_study_id, :students_limit, :recrutation_formula, :minimal_points)
  end

  def field_opinion_params
    params.require(:field_opinion).permit(:body, :is_positive, :user_id, :field_of_study_id, :academy_id)
  end
end
