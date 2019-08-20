class FieldsController < ApplicationController
  def index
    @all_fields = FieldOfStudy.all
    @fields = FieldOfStudy.order(:name).page params[:page]
  end

  def show
    @field = FieldOfStudy.find(params[:id])
  end

  def new
    @field = FieldOfStudy.new
    authorize! :create, @field
  end
end
