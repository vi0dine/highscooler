# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::DashboardController, type: :controller do
  describe 'GET :show' do
    context 'as a guest' do
      it 'redirect guests to homepage' do
        user = FactoryBot.create(:user)
        get :show, params: { id: user.id }
        should redirect_to(root_path)
      end
    end

    context 'as a logged in user' do
      render_views
      login_user(account_type: 'schoolboy')
      it 'displays user data' do
        get :show, params: { id: controller.current_user.id }
        expect(assigns(:user)).to eq(controller.current_user)
        expect(assigns(:fields)).to eq(controller.current_user.field_details)
        expect(assigns(:formulas)).to eq(controller.current_user.formulas)
        expect(assigns(:results)).to eq(controller.current_user.results)

        expect(response.body).to include('Raport')
        expect(response.body).to include(controller.current_user.username.to_s)
        expect(response.body).to include(controller.current_user.email.to_s)
      end
    end

    context 'as an admin' do
      render_views
      login_admin
      it 'displays admin panel' do
        get :show, params: { id: controller.current_user.id }
        expect(response.body).to include('Panel administracyjny')
      end
    end
  end
end
