class AcademiesController < ApplicationController
  def index
    @academies = Academy.order(:name).page params[:page]
  end

  def show
    @academy = Academy.find(params[:id])
    @academy_opinion = AcademyOpinion.new
  end

  def new
    @academy = Academy.new
    authorize! :create, @academy
  end

  def create
    authorize! :create, @academy
    @academy = Academy.new(academy_params)
    if @academy.save
      flash[:notice] = 'Uczelnia została utworzona'
      redirect_to root_path
    else
      flash[:alert] = 'Wystąpił błąd.'
      render 'new'
    end
  end

  def create_academy_opinion
    @academy_opinion = AcademyOpinion.new(academy_opinion_params)
    if @academy_opinion.save
      flash[:notice] = 'Opinia została dodana.'
      redirect_to academy_path(@academy_opinion.academy_id)
    else
      flash[:alert] = 'Wystąpił błąd podczas dodawania opinii'
      redirect_to academy_path(@academy_opinion.academy_id)
    end
    authorize! :create, @academy_opinion
  end

  private

  def academy_params
    params.require(:academy).permit(:name, :city, :academy_type)
  end

  def academy_opinion_params
    params.require(:academy_opinion).permit(:body, :is_positive, :academy_id, :user_id)
  end
end
