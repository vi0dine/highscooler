class Users::DashboardController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
end
