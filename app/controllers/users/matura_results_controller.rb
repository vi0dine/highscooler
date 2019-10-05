# frozen_string_literal: true

module Users
  class MaturaResultsController < ApplicationController
    def create
      @matura_result = MaturaResult.new(matura_results_params)
      if @matura_result.save
        flash[:notice] = 'Dodano wynik matury'
      else
        flash[:danger] = 'Coś poszło nie tak'
      end
      redirect_to dashboard_path(current_user.id)
    end

    # TODO: Bring update functionality to life
    def update
      if @matura_result.update(matura_results_params)
        flash[:notice] = 'Zaktualizowano wynik matury'
      else
        flash[:danger] = 'Coś poszło nie tak'
      end
      redirect_to dashboard_path(current_user.id)
    end

    def delete
      @matura_result = MaturaResult.find(params[:matura_result_id])
      if @matura_result.destroy
        flash[:notice] = 'Usunięto wynik matury'
      else
        flash[:danger] = 'Coś poszło nie tak'
      end
      redirect_to root_path
    end

    private

    def matura_results_params
      params.require(:matura_result).permit(:user_id, :level, :matura_subject_id, :result)
    end
  end
end
