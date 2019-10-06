# frozen_string_literal: true

require 'rails_helper'
require './app/services/recrutation_points_calculator'

describe RecrutationPointsCalculator do
  before {
    @physics = create(:field_of_study, name: 'Fizyka')
    @issp = create(:field_of_study, name: 'ISSP')
    @biotechnology = create(:field_of_study, name: 'Biotechnologia')
    @med = create(:field_of_study, name: 'Lekarski')

    create(:field_detail, field_of_study: @physics, recrutation_formula: "[(Fizyka_Pp*0)|(Fizyka_Pr*1.5)]+[(Matematyka_Pp*0.5)|(Matematyka_Pr*1.5)]+[(Biologia_Pp*0)|(Biologia_Pr*0.5)|(Chemia_Pp*0)|(Chemia_Pr*0.5)|(Geografia_Pp*0)|(Geografia_Pr*0.5)|(Informatyka_Pp*0)|(Informatyka_Pr*0.5)]+[(Język angielski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język francuski_Pp*0.2)|(Język francuski_Pr*0.4)|(Język hiszpański_Pp*0.2)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pp*0.2)|(Język rosyjski_Pr*0.4)|(Język włoski_Pp*0.2)|(Język włoski_Pr*0.4)]")
    create(:field_detail, field_of_study: @issp, recrutation_formula: "[(Fizyka_Pp*0)|(Fizyka_Pr*1.5)]+[(Matematyka_Pp*0.5)|(Matematyka_Pr*1.5)]+[(Informatyka_Pp*0)|(Informatyka_Pr*1.5)]+[(Biologia_Pp*0)|(Biologia_Pr*0.5)|(Chemia_Pp*0)|(Chemia_Pr*0.5)|(Geografia_Pp*0)|(Geografia_Pr*0.5)]+[(Język angielski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język francuski_Pp*0.2)|(Język francuski_Pr*0.4)|(Język hiszpański_Pp*0.2)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pp*0.2)|(Język rosyjski_Pr*0.4)|(Język włoski_Pp*0.2)|(Język włoski_Pr*0.4)]")
    create(:field_detail, field_of_study: @biotechnology, recrutation_formula: "[(Biologia_Pp*0.35)|(Biologia_Pr*0.5)|(Chemia_Pp*0.35)|(Chemia_Pr*0.5)|(Fizyka_Pp*0.35)|(Fizyka_Pr*0.5)|(Informatyka_Pp*0.35)|(Informatyka_Pr*0.5)|(Matematyka_Pp*0.35)|(Matematyka_Pr*0.5)|(Język angielski_Pp*0.35)|(Język angielski_Pr*0.5)|(Język francuski_Pp*0.35)|(Język francuski_Pr*0.5)|(Język hiszpański_Pp*0.35)|(Język hiszpański_Pr*0.5)|(Język rosyjski_Pp*0.35)|(Język rosyjski_Pr*0.5)|(Język włoski_Pp*0.35)|(Język włoski_Pr*0.5)]+[(Biologia_Pp*0.35)|(Biologia_Pr*0.5)|(Chemia_Pp*0.35)|(Chemia_Pr*0.5)|(Fizyka_Pp*0.35)|(Fizyka_Pr*0.5)|(Informatyka_Pp*0.35)|(Informatyka_Pr*0.5)|(Matematyka_Pp*0.35)|(Matematyka_Pr*0.5)|(Język angielski_Pp*0.35)|(Język angielski_Pr*0.5)|(Język francuski_Pp*0.35)|(Język francuski_Pr*0.5)|(Język hiszpański_Pp*0.35)|(Język hiszpański_Pr*0.5)|(Język rosyjski_Pp*0.35)|(Język rosyjski_Pr*0.5)|(Język włoski_Pp*0.35)|(Język włoski_Pr*0.5)]")
    create(:field_detail, field_of_study: @med, recrutation_formula: "[(Biologia_Pp*0)|(Biologia_Pr*1)]+[(Chemia_Pp*0)|(Chemia_Pr*1)|(Fizyka_Pp*0)|(Fizyka_Pr*1)]")
  }

  let(:user) { 
    User.create!(
      username: 'test',
      email: 'test@example.com',
      password: '12345678',
      account_type: 'schoolboy',
      matura_results: [
        MaturaResult.create(
          matura_subject: MaturaSubject.create(name: 'Fizyka', subject_type: :sciences),
          level: :advanced,
          result: 42
        ),
        MaturaResult.create(
          matura_subject: MaturaSubject.create(name: 'Matematyka', subject_type: :sciences),
          level: :basic,
          result: 100
        ),
        MaturaResult.create(
          matura_subject: MaturaSubject.create(name: 'Matematyka', subject_type: :sciences),
          level: :advanced,
          result: 32
        ),
        MaturaResult.create(
          matura_subject: MaturaSubject.create(name: 'Informatyka', subject_type: :sciences),
          level: :advanced,
          result: 60
        ),
        MaturaResult.create(
          matura_subject: MaturaSubject.create(name: 'Język angielski', subject_type: :humanities),
          level: :basic,
          result: 98
        ),
        MaturaResult.create(
          matura_subject: MaturaSubject.create(name: 'Język angielski', subject_type: :humanities),
          level: :advanced,
          result: 78
        )
      ],
      study_interests: [
        StudyInterest.create(
          field_of_study: @physics
        ),
        StudyInterest.create(
          field_of_study: @issp
        ),
        StudyInterest.create(
          field_of_study: @biotechnology
        ),
        StudyInterest.create(
          field_of_study: @med
        )
      ]
    )
  }

  context 'when formulas are valid' do
    it 'returns an array' do
      expect(RecrutationPointsCalculator.call(user)).to be_instance_of(Array)
    end

    it 'returned array contained only numbers' do
      expect(RecrutationPointsCalculator.call(user)).to all(be_a(Numeric))
    end

    it 'correctly calculate points' do
      expect(RecrutationPointsCalculator.call(user)).to contain_exactly(174.2, 234.2, 74, 42)
    end
  end

  context 'when some formula is broken' do
    before {
      create(:field_detail, field_of_study: @med, recrutation_formula: "[(Biologia_Pp*0)|(Biologia_Pr*1)][(Chemia_Pp***0)|(Chemia_Pr*1)|(Fizyka_Pp*0)|(Fizyka_Pr*1)")
    }
    it 'assign N/A to this result' do
      expect(RecrutationPointsCalculator.call(user)).to contain_exactly(174.2, 234.2, 74, 42, '-')
    end
  end
end
