# frozen_string_literal: true

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

  private

  def academy_params
    params.require(:academy).permit(:name, :city, :academy_type)
  end
end
