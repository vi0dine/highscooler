require 'recruitment_formula_calculator'
require 'rails_helper'

RSpec.describe RecruitmentFormulaCalculator do
  before do
    puts "Seeding matura subjects"
    MaturaSubject.create(name: 'Chemia', level: 'advanced', subject_type: 'sciences')
    MaturaSubject.create(name: 'Biologia', level: 'advanced', subject_type: 'sciences')
    MaturaSubject.create(name: 'Fizyka', level: 'advanced', subject_type: 'sciences')
    MaturaSubject.create(name: 'Informatyka', level: 'advanced', subject_type: 'sciences')
    MaturaSubject.create(name: 'Geografia', level: 'advanced', subject_type: 'sciences')
    MaturaSubject.create(name: 'Historia', level: 'advanced', subject_type: 'humanities')
    MaturaSubject.create(name: 'Wiedza o społeczeństwie', level: 'advanced', subject_type: 'humanities')
    MaturaSubject.create(name: 'Matematyka', level: 'advanced', subject_type: 'sciences')
    MaturaSubject.create(name: 'Matematyka', level: 'basic', subject_type: 'sciences')
    MaturaSubject.create(name: 'Polski', level: 'basic', subject_type: 'humanities')
    MaturaSubject.create(name: 'Polski', level: 'advanced', subject_type: 'humanities')
    MaturaSubject.create(name: 'Angielski', level: 'advanced', subject_type: 'humanities')
    MaturaSubject.create(name: 'Angielski', level: 'basic',  subject_type: 'humanities')
    MaturaSubject.create(name: 'Niemiecki', level: 'advanced', subject_type: 'humanities')
    MaturaSubject.create(name: 'Niemiecki', level: 'basic',  subject_type: 'humanities')
    MaturaSubject.create(name: 'Francuski', level: 'advanced', subject_type: 'humanities')
    MaturaSubject.create(name: 'Francuski', level: 'basic', subject_type: 'humanities')
    MaturaSubject.create(name: 'Hiszpański', level: 'advanced', subject_type: 'humanities')
    MaturaSubject.create(name: 'Hiszpański', level: 'basic', subject_type: 'humanities')
    MaturaSubject.create(name: 'Rosyjski', level: 'advanced', subject_type: 'humanities')
    MaturaSubject.create(name: 'Rosyjski', level: 'basic', subject_type: 'humanities')
    MaturaSubject.create(name: 'Włoski', level: 'advanced', subject_type: 'humanities')
    MaturaSubject.create(name: 'Włoski', level: 'basic', subject_type: 'humanities')
    MaturaSubject.create(name: 'Łaciński i kultura antyczna', level: 'advanced', subject_type: 'humanities')
  end

  describe "with valid values" do
    let(:formula) { "[(chemia_pr*2)|(biologia_pr*2)]+[(chemia_pr*2)|(fizyka_pr*2)]+[(angielski_pp*0.2)|(angielski_pr*0.4)|(niemiecki_pp*0.2)|(niemiecki_pr*0.4)|(francuski_pp*0.2)|(francuski_pr*0.4)|]" }

    it "calculate correct result (simplest example)" do
      user = create(:user)

      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Chemia", level: :advanced).take, result: 70, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Biologia", level: :advanced).take, result: 13, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Fizyka", level: :advanced).take, result: 20, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Angielski", level: :basic).take, result: 100, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Angielski", level: :advanced).take, result: 51, user: user)

      expect(RecruitmentFormulaCalculator::Formula.new(formula).calculate(user)).to eq(200.4)
    end

    it "calculate BEST result (harder example)" do
      user = create(:user)

      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Chemia", level: :advanced).take, result: 70, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Biologia", level: :advanced).take, result: 25, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Fizyka", level: :advanced).take, result: 20, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Angielski", level: :basic).take, result: 100, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Angielski", level: :advanced).take, result: 51, user: user)

      expect(RecruitmentFormulaCalculator::Formula.new(formula).calculate(user)).to eq(210.4)
    end

    it "calculate very BEST result (even harder example)" do
      user = create(:user)

      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Chemia", level: :advanced).take, result: 30, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Biologia", level: :advanced).take, result: 30, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Fizyka", level: :advanced).take, result: 20, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Angielski", level: :basic).take, result: 100, user: user)
      MaturaResult.create!(matura_subject: MaturaSubject.where(name: "Angielski", level: :advanced).take, result: 51, user: user)

      expect(RecruitmentFormulaCalculator::Formula.new(formula).calculate(user)).to eq(140.4)
    end
  end
end