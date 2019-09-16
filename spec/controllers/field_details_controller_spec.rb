# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FieldDetailsController, type: :controller do
  render_views

  it {
    expect permit(:academy_id, :field_of_study_id, :students_limit,
                  :recrutation_formula, :minimal_points)
      .for(:create)
      .on(:field_detail)
  }

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
      it { expect(response.body).to include('Dodaj szczegóły kierunku na uczelni') }
    end
  end

  describe 'POST :create' do
    context 'as a regular user' do
      login_user(account_type: 'schoolboy')
      it {
        academy = FactoryBot.create(:academy)
        field = FactoryBot.create(:field_of_study)
        post :create, params: {
          field_detail: FactoryBot.attributes_for(:field_detail, 
                                                  academy_id: academy.id,
                                                  field_of_study_id: field.id)
        }
        should redirect_to(root_path)
      }
      it {
        academy = FactoryBot.create(:academy)
        field = FactoryBot.create(:field_of_study)
        expect {
          post :create, params: {
            field_detail: FactoryBot.attributes_for(:field_detail,
                                                    academy_id: academy.id,
                                                    field_of_study_id: field.id)
          }
        }.to change { FieldDetail.count }.by 0
      }
    end

    context 'as an admin' do
      login_admin
      context 'with valid attributes' do
        it {
          academy = FactoryBot.create(:academy)
          field = FactoryBot.create(:field_of_study)
          post :create, params: {
            field_detail: FactoryBot.attributes_for(:field_detail, 
                                                    academy_id: academy.id,
                                                    field_of_study_id: field.id)
          }
          expect(controller).to set_flash[:notice]
          should redirect_to(root_path)
        }

        it {
          academy = FactoryBot.create(:academy)
          field = FactoryBot.create(:field_of_study)
          expect {
            post :create, params: {
              field_detail: FactoryBot.attributes_for(:field_detail,
                                                      academy_id: academy.id,
                                                      field_of_study_id: field.id)
            }
          }.to change { FieldDetail.count }.by 1
        }
      end

      context 'with invalid attributes' do
        it {
          academy = FactoryBot.create(:academy)
          field = FactoryBot.create(:field_of_study)
          post :create, params: {
            field_detail: FactoryBot.attributes_for(:field_detail, :invalid,
                                                    academy_id: academy.id,
                                                    field_of_study_id: field.id)
          }
          expect(controller).to set_flash[:alert]
          should render_template(:new)
        }

        it {
          academy = FactoryBot.create(:academy)
          field = FactoryBot.create(:field_of_study)
          expect {
            post :create, params: {
              field_detail: FactoryBot.attributes_for(:field_detail, :invalid,
                                                      academy_id: academy.id,
                                                      field_of_study_id: field.id)
            }
          }.to change { FieldDetail.count }.by 0
        }
      end

      context 'with already existed one' do
        before do
          @academy = FactoryBot.create(:academy)
          @field = FactoryBot.create(:field_of_study)
          post :create, params: {
            field_detail: FactoryBot.attributes_for(:field_detail,
                                                    academy_id: @academy.id,
                                                    field_of_study_id: @field.id)
          }
        end
        it {
          post :create, params: {
            field_detail: FactoryBot.attributes_for(:field_detail,
                                                    academy_id: @academy.id,
                                                    field_of_study_id: @field.id)
          }
          expect(controller).to set_flash[:alert]
          should render_template(:new)
        }

        it {
          expect {
            post :create, params: {
              field_detail: FactoryBot.attributes_for(:field_detail,
                                                      academy_id: @academy.id,
                                                      field_of_study_id: @field.id)
            }
          }.to change { FieldDetail.count }.by 0
        }
      end
    end
  end
end
