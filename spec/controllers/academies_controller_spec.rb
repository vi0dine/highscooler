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
      academy = FactoryBot.create(:academy)
      get :index
      expect(assigns(:academies)).to eq([academy])
    end
  end
end
