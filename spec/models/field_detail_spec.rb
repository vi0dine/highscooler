require 'rails_helper'

RSpec.describe FieldDetail, type: :model do
  let(:field_detail) { create(:field_detail) }

  describe 'validations' do
    it { should validate_presence_of(:recrutation_formula) }
    it { should belong_to(:academy) }
    it { should belong_to(:field_of_study) }
  end
end
