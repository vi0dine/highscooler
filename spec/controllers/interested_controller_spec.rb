# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InterestedController, type: :controller do
  describe 'POST :create' do
    context 'when quest' do
      it 'should redirect to homepage' do
        user = FactoryBot.create(:user)
        detail = FactoryBot.create(:field_detail)
        post :create, params:
        {
          id: user.id,
          interested: FactoryBot.attributes_for(:interested,
                                                field_detail_id: detail.id,
                                                user_id: user.id)
        }
        should redirect_to(root_path)
      end

      it 'should not add new Interested' do
        user = FactoryBot.create(:user)
        detail = FactoryBot.create(:field_detail)
        expect {
          post :create, params: {
            id: user.id,
            interested: FactoryBot.attributes_for(:interested,
                                                  field_detail_id: detail.id,
                                                  user_id: user.id)
          }
        }.to change { Interested.count }.by 0
      end
    end

    context 'when logged in user' do
      login_user
      it {
        expect permit(:user_id, :field_detail_id)
          .for(:create)
          .on(:interested)
      }

      context 'with valid parameters' do
        it 'should notice when successful' do
          field_detail = FactoryBot.create(:field_detail)
          post :create, params: {
            id: controller.current_user.id,
            interested: FactoryBot.attributes_for(:interested,
                                                  field_detail_id: field_detail.id,
                                                  user_id: controller.current_user.id)
          }
          should redirect_to(dashboard_path(controller.current_user.id))
          expect(controller).to set_flash[:notice]
        end

        it 'should add new interest to db' do
          field_detail = FactoryBot.create(:field_detail)
          expect {
            post :create, params: {
              id: controller.current_user.id,
              interested: FactoryBot.attributes_for(:interested,
                                                    field_detail_id: field_detail.id,
                                                    user_id: controller.current_user.id)
            }
          }.to change { Interested.count }.by 1
        end

        it 'should add new interest to the current user' do
          field_detail = FactoryBot.create(:field_detail)
          expect {
            post :create, params: {
              id: controller.current_user.id,
              interested: FactoryBot.attributes_for(:interested,
                                                    field_detail_id: field_detail.id,
                                                    user_id: controller.current_user.id)
            }
          }.to change { controller.current_user.interesteds.count }.by 1
        end

        it 'should not add already existed interested' do
          field_detail = FactoryBot.create(:field_detail)
          post :create, params: {
            id: controller.current_user.id,
            interested: FactoryBot.attributes_for(:interested,
                                                  field_detail_id: field_detail.id,
                                                  user_id: controller.current_user.id)
          }
          expect {
            post :create, params: {
              id: controller.current_user.id,
              interested: FactoryBot.attributes_for(:interested,
                                                    field_detail_id: field_detail.id,
                                                    user_id: controller.current_user.id)
            }
          }.to change { controller.current_user.interesteds.count }.by 0
        end
      end

      context 'with invalid parameters' do
        it 'should alert when unsuccessful' do
          post :create, params: {
            id: controller.current_user.id,
            interested: FactoryBot.attributes_for(:interested,
                                                  field_detail_id: nil,
                                                  user_id: controller.current_user.id)
          }
          should redirect_to(dashboard_path(controller.current_user.id))
          expect(controller).to set_flash[:alert]
        end

        it 'should not add new interest to the current user' do
          field_detail = FactoryBot.create(:field_detail)
          expect {
            post :create, params: {
              id: controller.current_user.id,
              interested: FactoryBot.attributes_for(:interested,
                                                    field_detail_id: field_detail.id,
                                                    user_id: nil)
            }
          }.to change { controller.current_user.interesteds.count }.by 0
        end
      end
    end
  end
end
