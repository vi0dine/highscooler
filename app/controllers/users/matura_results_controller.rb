module Users
  class MaturaResultsController < ApplicationController
    def edit
    end

    private

    def matura_results_params
      params.require(:matura_results).permit(:user_id, :level, :matura_subject_id, :result)
    end
  end
end