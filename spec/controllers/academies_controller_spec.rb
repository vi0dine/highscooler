# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AcademiesController, type: :controller do
  render_views

  describe 'GET :index' do
    before(:each) do
      get :index
    end

    it { should respond_with(200) }
    it { should render_template(:index) }

    it 'assign @academies' do
      academies = FactoryBot.create_list(:academy, 8)
      get :index
      expect(assigns(:academies)).to eq(academies[0..4])
    end
  end

  describe 'GET :show' do
    before(:each) do
      @academy = FactoryBot.create(:academy)
      get :show, params: { id: @academy.id }
    end

    it { should respond_with(200) }
    it { should render_template(:show) }

    it 'assign @academy' do
      expect(assigns(:academy)).to eq(@academy)
    end

    it 'render academy info' do
      expect(response.body).to include(@academy.name.to_s)
      expect(response.body).to include(@academy.city.to_s)
    end
  end
end
