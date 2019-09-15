# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HighSchoolsController, type: :controller do
  render_views

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
      it { expect(response.body).to include('Dodaj szkołę') }
    end
  end

  describe 'POST :create' do
    it 'permit valid params' do
      expect permit(:name, :city, :school_type).for(:create, verb: :post).on(:high_school)
    end

    context 'as a regular user' do
      login_user(account_type: 'schoolboy')
      before(:each) do
        post :create, params: { high_school: FactoryBot.attributes_for(:high_school, school_type: :general) }
      end
      it {
        expect { post :create, params: { high_school: FactoryBot.attributes_for(:high_school, school_type: :general) } }
          .to change { HighSchool.count }.by 0
      }
      it { should redirect_to(root_path) }
    end

    context 'as an admin' do
      login_admin

      context 'with valid attributes' do
        it {
          expect { post :create, params: { high_school: FactoryBot.attributes_for(:high_school, school_type: :general) } }
            .to change { HighSchool.count }.by 1
        }
        it {
          post :create, params: { high_school: FactoryBot.attributes_for(:high_school, school_type: :general) }
          should redirect_to(root_path)
        }
      end

      context 'with invalid attributes' do
        it {
          expect { post :create, params: { high_school: FactoryBot.attributes_for(:high_school, :invalid, school_type: :general) } }
            .to change { HighSchool.count }.by 0
        }
        it {
          post :create, params: { high_school: FactoryBot.attributes_for(:high_school, :invalid, school_type: :general) }
          should render_template(:new)
        }
        it {
          post :create, params: { high_school: FactoryBot.attributes_for(:high_school, :invalid, school_type: :general) }
          expect(controller).to set_flash[:alert]
        }
      end
    end
  end
end
