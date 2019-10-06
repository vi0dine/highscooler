# frozen_string_literal: true

require 'rails_helper'
require './app/services/recrutation_points_calculator'

describe RecrutationPointsCalculator do\
  let(:user) { create(:user) }
  before {
    physics = create(:field_of_study, name: 'Fizyka')
    issp = create(:field_of_study, name: 'ISSP')
    biotechnology = create(:field_of_study, name: 'Biotechnologia')
    med = create(:field_of_study, name: 'Lekarski')

    create(:field_detail, field_of_study: physics, recrutation_formula: "[(Fizyka_Pp*0)|(Fizyka_Pr*1.5)]+[(Matematyka_Pp*0.5)|(Matematyka_Pr*1.5)]+[(Biologia_Pp*0)|(Biologia_Pr*0.5)|(Chemia_Pp*0)|(Chemia_Pr*0.5)|(Geografia_Pp*0)|(Geografia_Pr*0.5)|(Informatyka_Pp*0)|(Informatyka_Pr*0.5)]+[(Język angielski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język francuski_Pp*0.2)|(Język francuski_Pr*0.4)|(Język hiszpański_Pp*0.2)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pp*0.2)|(Język rosyjski_Pr*0.4)|(Język włoski_Pp*0.2)|(Język włoski_Pr*0.4)]")
    create(:field_detail, field_of_study: issp, recrutation_formula: "[(Fizyka_Pp*0)|(Fizyka_Pr*1.5)]+[(Matematyka_Pp*0.5)|(Matematyka_Pr*1.5)]+[(Informatyka_Pp*0)|(Informatyka_Pr*1.5)]+[(Biologia_Pp*0)|(Biologia_Pr*0.5)|(Chemia_Pp*0)|(Chemia_Pr*0.5)|(Geografia_Pp*0)|(Geografia_Pr*0.5)]+[(Język angielski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język francuski_Pp*0.2)|(Język francuski_Pr*0.4)|(Język hiszpański_Pp*0.2)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pp*0.2)|(Język rosyjski_Pr*0.4)|(Język włoski_Pp*0.2)|(Język włoski_Pr*0.4)]")
    create(:field_detail, field_of_study: biotechnology, recrutation_formula: "[(Biologia_Pp*0.35)|(Biologia_Pr*0.5)|(Chemia_Pp*0.35)|(Chemia_Pr*0.5)|(Fizyka_Pp*0.35)|(Fizyka_Pr*0.5)|(Informatyka_Pp*0.35)|(Informatyka_Pr*0.5)|(Matematyka_Pp*0.35)|(Matematyka_Pr*0.5)|(Język angielski_Pp*0.35)|(Język angielski_Pr*0.5)|(Język francuski_Pp*0.35)|(Język francuski_Pr*0.5)|(Język hiszpański_Pp*0.35)|(Język hiszpański_Pr*0.5)|(Język rosyjski_Pp*0.35)|(Język rosyjski_Pr*0.5)|(Język włoski_Pp*0.35)|(Język włoski_Pr*0.5)]+[(Biologia_Pp*0.35)|(Biologia_Pr*0.5)|(Chemia_Pp*0.35)|(Chemia_Pr*0.5)|(Fizyka_Pp*0.35)|(Fizyka_Pr*0.5)|(Informatyka_Pp*0.35)|(Informatyka_Pr*0.5)|(Matematyka_Pp*0.35)|(Matematyka_Pr*0.5)|(Język angielski_Pp*0.35)|(Język angielski_Pr*0.5)|(Język francuski_Pp*0.35)|(Język francuski_Pr*0.5)|(Język hiszpański_Pp*0.35)|(Język hiszpański_Pr*0.5)|(Język rosyjski_Pp*0.35)|(Język rosyjski_Pr*0.5)|(Język włoski_Pp*0.35)|(Język włoski_Pr*0.5)]")
    create(:field_detail, field_of_study: med, recrutation_formula: "[(Biologia_Pp*0)|(Biologia_Pr*1)]+[(Chemia_Pp*0)|(Chemia_Pr*1)|(Fizyka_Pp*0)|(Fizyka_Pr*1)]")

    create(:study_interest, user: user, field_of_study: physics)
    create(:study_interest, user: user, field_of_study: issp)
    create(:study_interest, user: user, field_of_study: biotechnology)
    create(:study_interest, user: user, field_of_study: med)
  }

end
