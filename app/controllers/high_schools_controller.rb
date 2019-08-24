class HighSchoolsController < ApplicationController
  def new
    @highschool = HighSchool.new
    authorize! :create, @highschool
  end

  def create
    authorize! :create, @highschool
    @highschool = HighSchool.new(high_school_params)
    if @highschool.save
      flash[:notice] = 'Szkoła została utworzona'
      redirect_to root_path
    else
      render 'new'
    end
  end

  private

  def high_school_params
    params.require(:high_school).permit(:name, :city, :school_type)
  end
end
