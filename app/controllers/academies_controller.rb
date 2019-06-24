class AcademiesController < ApplicationController
  def index
    @academies = Academy.order(:name).page params[:page]
  end
end
