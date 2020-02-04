module Types
  module Enums
    class Gender < Types::Base::BaseEnum
      description 'All available genders'

      value('male', 'Man')
      value('female', 'Woman')
    end

    class Role < Types::Base::BaseEnum
      description 'All available roles'

      value('schoolboy', 'Candidate for studies')
      value('student', 'Student from some academy')
      value('partner', 'Sub-admin for one academy')
      value('admin', 'Superuser')
    end
  end
end