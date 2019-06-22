class Users::DashboardController < ApplicationController
  def show
    @user = User.find(params[:id])
    @fields = []
    @user.field_of_studies.each do |fos|
      fos.field_details.each do |fd|
        @fields << fd
      end
    end
  end
end
