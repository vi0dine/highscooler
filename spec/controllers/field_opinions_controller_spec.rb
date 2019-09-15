# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FieldOpinionsController, type: :controller do
  describe 'POST :create' do
    it {
      expect permit(:body, :is_positive, :academy_id, :user_id, :field_of_study_id)
        .for(:create).on(:field_opinion)
    }

    context 'as a regular user' do
      login_user(account_type: 'schoolboy')

      it {
        academy = FactoryBot.create(:academy)
        field_of_study = FactoryBot.create(:field_of_study)
        post :create, params: {
          field_opinion: FactoryBot.attributes_for(:field_opinion,
                                                     academy_id: academy.id,
                                                     field_of_study_id: field_of_study.id,
                                                     user_id: controller.current_user.id)
        }
        should redirect_to(root_path)
      }

      it {
        academy = FactoryBot.create(:academy)
        field_of_study = FactoryBot.create(:field_of_study)
        expect {
          post :create, params: {
            field_opinion: FactoryBot.attributes_for(:field_opinion,
                                                     academy_id: academy.id,
                                                     field_of_study_id: field_of_study.id,
                                                     user_id: controller.current_user.id)
          }
        }.to change { FieldOpinion.count }.by 0
      }
    end

    context 'as an admin' do
      before(:each) { DatabaseCleaner.clean }
      login_admin

      it 'should alert when not successful' do
        academy = FactoryBot.create(:academy)
        field_of_study = FactoryBot.create(:field_of_study)
        post :create, params: {
          field_opinion: FactoryBot.attributes_for(:field_opinion, :invalid,
                                                     academy_id: academy.id,
                                                     field_of_study_id: field_of_study.id,
                                                     user_id: controller.current_user.id)
        }
        should redirect_to(field_path(field_of_study.id))
        expect(controller).to set_flash[:alert]
      end

      it 'should notice when successful' do
        academy = FactoryBot.create(:academy)
        field_of_study = FactoryBot.create(:field_of_study)
        post :create, params: {
          field_opinion: FactoryBot.attributes_for(:field_opinion,
                                                     academy_id: academy.id,
                                                     field_of_study_id: field_of_study.id,
                                                     user_id: controller.current_user.id)
        }
        should redirect_to(field_path(field_of_study.id))
        expect(controller).to set_flash[:notice]
      end

      it {
        expect {
          academy = FactoryBot.create(:academy)
          field_of_study = FactoryBot.create(:field_of_study)
          post :create, params: {
            field_opinion: FactoryBot.attributes_for(:field_opinion,
                                                     academy_id: academy.id,
                                                     field_of_study_id: field_of_study.id,
                                                     user_id: controller.current_user.id)
          }
        }.to change { FieldOpinion.count }.by 1
      }

      it "can't add multiple opinions" do
        @academy = FactoryBot.create(:academy)
        @field_of_study = FactoryBot.create(:field_of_study)
        post :create, params: {
          field_opinion: FactoryBot.attributes_for(:field_opinion, :invalid,
                                                     academy_id: @academy.id,
                                                     field_of_study_id: @field_of_study.id,
                                                     user_id: controller.current_user.id)
        }
        expect {
          post :create, params: {
            field_opinion: FactoryBot.attributes_for(:field_opinion, :invalid,
                                                       academy_id: @academy.id,
                                                       field_of_study_id: @field_of_study.id,
                                                       user_id: controller.current_user.id)
          }
        }.to change { FieldOpinion.count }.by 0
      end
    end

    context 'as a student' do
      login_student

      context 'when adding opinion to not yours academy' do
        academy = FactoryBot.create(:academy)
        it 'redirects to root page' do
          post :create, params: {
            field_opinion: FactoryBot.attributes_for(:field_opinion,
                                                     user_id: controller.current_user.id,
                                                     field_of_study_id: controller.current_user.field_of_study.id,
                                                     academy_id: academy.id)
          }
          should redirect_to(field_path(controller.current_user.field_of_study.id))
        end

        it 'adds opinion' do
          expect {
            post :create, params: {
              field_opinion: FactoryBot.attributes_for(:field_opinion,
                                                       user_id: controller.current_user.id,
                                                       field_of_study_id: controller.current_user.field_of_study.id,
                                                       academy_id: academy.id)
            }
          }.to change { FieldOpinion.count }.by 1
        end
      end

      context 'when adding opinion to not yours field' do
        field = FactoryBot.create(:field_of_study, id: 100)
        
        it 'redirects to root page' do
          post :create, params: {
            field_opinion: FactoryBot.attributes_for(:field_opinion,
                                                     user_id: controller.current_user.id,
                                                     field_of_study_id: field.id,
                                                     academy_id: controller.current_user.academy.id)
          }
          should redirect_to(root_path)
        end

        it 'does not add opinion' do
          expect {
            post :create, params: {
              field_opinion: FactoryBot.attributes_for(:field_opinion,
                                                      user_id: controller.current_user.id,
                                                      field_of_study_id: field.id,
                                                      academy_id: controller.current_user.academy.id)
            }
          }.to change { FieldOpinion.count }.by 0
        end
      end

      context 'when adding opinion to yours academy and field' do
        it 'add opinion to db' do
          expect {
            post :create, params: {
              field_opinion: FactoryBot.attributes_for(:field_opinion,
                                                       user_id: controller.current_user.id,
                                                       field_of_study_id: controller.current_user.field_of_study.id,
                                                       academy_id: controller.current_user.academy.id)
            }
          }.to change { FieldOpinion.count }.by 1
        end

        it 'notifies about success' do
          post :create, params: {
            field_opinion: FactoryBot.attributes_for(:field_opinion,
                                                     user_id: controller.current_user.id,
                                                     field_of_study_id: controller.current_user.field_of_study.id,
                                                     academy_id: controller.current_user.academy.id)
          }
          expect(controller).to set_flash[:notice]
        end
      end
    end
  end
end
