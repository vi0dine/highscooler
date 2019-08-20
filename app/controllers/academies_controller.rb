class AcademiesController < ApplicationController
  def index
    @academies = Academy.order(:name).page params[:page]
  end

  def show
    @academy = Academy.find(params[:id])
  end

  def new
    @academy = Academy.new
  end
end
