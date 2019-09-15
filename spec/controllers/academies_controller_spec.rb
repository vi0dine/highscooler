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
      academies = FactoryBot.create_list(:academy, 10).sort_by(&:name)
      get :index
      expect(assigns(:academies)).to eq(academies[0..4])
      expect(assigns(:academies).count).to eq(5)
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

    it 'prepare new academy opinion' do
      expect(assigns(:academy_opinion)).to be_a_new(AcademyOpinion)
    end
  end

  describe 'GET :new' do
    context 'as a regular user' do
      login_user(account_type: 'schoolboy')
      before(:each) do
        get :new
      end
      it { expect(response).to_not render_template(:new) }
      it { should redirect_to(root_path) }
    end

    context 'as an admin' do
      login_admin
      before(:each) do
        get :new
      end
      it { should respond_with(200) }
      it { should render_template(:new) }
      it { expect(response.body).to include('Dodaj uczelnię') }
    end
  end

  describe 'POST :create' do
    it 'permit valid params' do
      expect permit(:name, :city, :academy_type).for(:create, verb: :post).on(:academy)
    end

    context 'as a regular user' do
      login_user(account_type: 'schoolboy')
      before(:each) do
        post :create, params: { academy: FactoryBot.attributes_for(:academy) }
      end
      it {
        expect { post :create, params: { academy: FactoryBot.attributes_for(:academy) } }
          .to change { Academy.count }.by 0
      }
      it { should redirect_to(root_path) }
    end

    context 'as an admin' do
      login_admin

      context 'with valid attributes' do
        before(:each) do
          post :create, params: { academy: FactoryBot.attributes_for(:academy, academy_type: :university) }
        end
        it {
          expect { post :create, params: { academy: FactoryBot.attributes_for(:academy, academy_type: :university) } }
            .to change { Academy.count }.by 1
        }
        it { should redirect_to(root_path) }
      end

      context 'with invalid attributes' do
        it {
          expect { post :create, params: { academy: FactoryBot.attributes_for(:academy, :invalid) } }
            .to raise_error(ArgumentError)
        }
      end
    end
  end
end
