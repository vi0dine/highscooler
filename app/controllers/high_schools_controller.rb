# frozen_string_literal: true

class HighSchoolsController < ApplicationController
  def new
    @highschool = HighSchool.new
    authorize! :create, @highschool
  end

  def create
    @highschool = HighSchool.new(high_school_params)
    authorize! :create, @highschool
    if @highschool.save
      flash[:notice] = 'Szkoła została utworzona'
      redirect_to root_path
    else
      flash[:alert] = 'Coś poszło nie tak'
      render 'new'
    end
  end

  private

  def high_school_params
    params.require(:high_school).permit(:name, :city, :school_type)
  end
end
