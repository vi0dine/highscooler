# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FieldsController, type: :controller do
  render_views

  describe 'GET :index' do
    before(:each) {
      get :index
    }
    it { should respond_with(200) }
    it { should render_template(:index) }
    it 'assign @fields' do
      fields = FactoryBot.create_list(:field_of_study, 10).sort_by(&:name)
      get :index
      expect(assigns(:fields)).to eq(fields[0..4])
      expect(assigns(:fields).count).to eq(5)
    end
  end

  describe 'GET :show' do
    before(:each) do
      @field = FactoryBot.create(:field_of_study)
      get :show, params: { id: @field.id }
    end

    it { should respond_with(200) }
    it { should render_template(:show) }

    it 'assign @field' do
      expect(assigns(:field)).to eq(@field)
    end

    it 'render field info' do
      expect(response.body).to include(@field.name.to_s)
      expect(response.body).to include(@field.field_type.to_s)
    end

    it 'prepare new field opinion' do
      expect(assigns(:field_opinion)).to be_a_new(FieldOpinion)
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
      it { expect(response.body).to include('Dodaj kierunek') }
    end
  end

  describe 'POST :create' do
    it 'permit valid params' do
      expect permit(:name, :field_type).for(:create, verb: :post).on(:field_of_study)
    end

    context 'as a regular user' do
      login_user(account_type: 'schoolboy')
      before(:each) do
        post :create, params: {
          field_of_study: FactoryBot.attributes_for(:field_of_study, field_type: :natural_sciences)
        }
      end

      it {
        expect {
          post :create, params: {
            field_of_study: FactoryBot.attributes_for(:field_of_study, field_type: :natural_sciences)
          }
        }.to change { FieldOfStudy.count }.by 0
      }
      it { should redirect_to(root_path) }
    end

    context 'as an admin' do
      login_admin

      context 'with valid attributes' do
        before(:each) do
          post :create, params: {
            field_of_study: FactoryBot.attributes_for(:field_of_study, field_type: :natural_sciences)
          }
        end

        it {
          expect {
            post :create, params: {
              field_of_study: FactoryBot.attributes_for(:field_of_study, field_type: :natural_sciences)
            }
          }.to change { FieldOfStudy.count }.by 1
        }

        it { expect(controller).to set_flash[:notice] }
        it { should redirect_to(root_path) }
      end

      context 'with invalid attributes' do
        it {
          expect {
            post :create, params: {
              field_of_study: FactoryBot.attributes_for(:field_of_study, :invalid)
            }
          }.to raise_error(ArgumentError)
        }

        it {
          expect {
            post :create, params: {
              field_of_study: FactoryBot.attributes_for(:field_of_study, :invalid, 
                                                        field_type: :natural_sciences)
            }
          }.to change { FieldOfStudy.count }.by 0
        }
      end
    end
  end
end
