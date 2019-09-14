# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AcademyOpinionsController, type: :controller do
  describe 'POST :create' do
    it {
      expect permit(:body, :is_positive, :academy_id, :user_id)
        .for(:create).on(:academy_opinion)
    }

    context 'as a regular user' do
      login_user(account_type: 'schoolboy')
      before(:each) do
        post :create, params: {
          academy_opinion: FactoryBot.attributes_for(:academy_opinion,
                                                     academy_id: 1,
                                                     user_id: controller.current_user.id)
        }
      end
      it { should redirect_to(root_path) }
      it {
        expect { post :create, params: { academy_opinion: FactoryBot.attributes_for(:academy_opinion) } }
          .to change { AcademyOpinion.count }.by 0
      }
    end

    context 'as an admin' do
      login_admin
      it 'should alert when not successful' do
        post :create, params: { academy_opinion: FactoryBot.attributes_for(:academy_opinion, user_id: 150, academy_id: 150) }
        should redirect_to(academy_path(150))
        expect(controller).to set_flash[:alert]
      end
      it 'should notice when successful' do
        @academy = FactoryBot.create(:academy)
        post :create, params: {
          academy_opinion: FactoryBot.attributes_for(:academy_opinion,
                                                     user_id: controller.current_user.id,
                                                     academy_id: @academy.id)
        }
        should redirect_to(academy_path(@academy.id))
        expect(controller).to set_flash[:notice]
      end
      it {
        @academy = FactoryBot.create(:academy)
        expect {
          post :create, params: {
            academy_opinion: FactoryBot.attributes_for(:academy_opinion,
                                                       user_id: controller.current_user.id,
                                                       academy_id: @academy.id)
          }
        }
          .to change { AcademyOpinion.count }.by 1
      }
    end

    context 'as a student of academy' do
      login_student
      context 'when adding opinion to not yours academy' do
        academy = FactoryBot.create(:academy, id: 100)
        it 'redirects to root page' do
          post :create, params: {
            academy_opinion: FactoryBot.attributes_for(:academy_opinion,
                                                       user_id: controller.current_user.id,
                                                       academy_id: academy.id)
          }
          should redirect_to(root_path)
        end

        it 'dont add opinion' do
          expect {
            post :create, params: {
              academy_opinion: FactoryBot.attributes_for(:academy_opinion,
                                                         user_id: controller.current_user.id,
                                                         academy_id: academy.id)
            }
          }.to change { AcademyOpinion.count }.by 0
        end
      end

      context 'when adding opinion to yours academy' do
        it 'add opinion to db' do
          expect {
            post :create, params: {
              academy_opinion: FactoryBot.attributes_for(:academy_opinion,
                                                         user_id: controller.current_user.id,
                                                         academy_id: controller.current_user.academy.id)
            }
          }.to change { AcademyOpinion.count }.by 1
        end

        it 'notifies about success' do
          post :create, params: {
            academy_opinion: FactoryBot.attributes_for(:academy_opinion,
                                                       user_id: controller.current_user.id,
                                                       academy_id: controller.current_user.academy.id)
          }
          expect(controller).to set_flash[:notice]
        end
      end
    end
  end
end
