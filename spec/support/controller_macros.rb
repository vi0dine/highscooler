# frozen_string_literal: true

module ControllerMacros
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in FactoryBot.create(:user, account_type: 'admin')
    end
  end

  def login_user(params = {})
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, params)
      sign_in user
    end
  end

  def login_student
    before(:each) do
      academy = FactoryBot.create(:academy)
      field = FactoryBot.create(:field_of_study)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      user = FactoryBot.create(:user, account_type: 'student', academy: academy, field_of_study: field)
      sign_in user
    end
  end
end
