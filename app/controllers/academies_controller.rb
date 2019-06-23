class AcademiesController < ApplicationController
  def index
    @academies = Academy.all
  end
end
