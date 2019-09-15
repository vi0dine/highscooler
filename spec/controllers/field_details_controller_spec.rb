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
end
