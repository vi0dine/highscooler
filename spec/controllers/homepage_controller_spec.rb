# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomepageController, type: :controller do
  render_views

  describe 'GET :index' do
    context 'as a login user' do
      login_user
      before { get :index }
      it { should redirect_to(dashboard_path(controller.current_user.id)) }
    end

    context 'as a quest' do
      before { get :index }
      it { should render_template(:index) }
      it { expect(response.body).to include('Witaj') }
    end
  end
end
