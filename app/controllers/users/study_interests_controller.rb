# frozen_string_literal: true

module Users
  class StudyInterestsController < ApplicationController
    def create
      @study_interest = StudyInterest.new(study_interest_params)
      if @study_interest.save
        flash[:notice] = 'Dodano kierunek studiów'
      else
        flash[:danger] = 'Coś poszło nie tak'
      end
      redirect_to dashboard_path(current_user.id), method: :get
    end

    def delete
      study_interest = StudyInterest.where(user_id: study_interest_params[:user_id],
                                           field_of_study_id: study_interest_params[:field_of_study_id])

      if study_interest.destroy_all
        flash[:notice] = 'Usunięto kierunek z zainteresowań'
      else
        flash[:danger] = 'Coś poszło nie tak'
      end
      redirect_to root_path
    end

    private

    def study_interest_params
      params.require(:study_interest).permit(:user_id, :field_of_study_id)
    end
  end
end