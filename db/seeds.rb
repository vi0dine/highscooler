# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# FieldOfStudies samples
  # Uniwersytet Wrocławski
  FieldOfStudy.create(name: 'Chemia i toksykologia sądowa', field_type: 5)
  FieldOfStudy.create(name: 'Indywidualne studia międzyobszarowe', field_type: 16)
  FieldOfStudy.create(name: 'Politologia', field_type: 4)
  FieldOfStudy.create(name: 'Geografia', field_type: 5)
  FieldOfStudy.create(name: 'Genetyka i biologia eksperymentalna', field_type: 5)
  FieldOfStudy.create(name: 'Kulturoznawstwo', field_type: 0)
  FieldOfStudy.create(name: 'Astronomia', field_type: 5)
  FieldOfStudy.create(name: 'Biologia człowieka', field_type: 5)
  FieldOfStudy.create(name: 'Filologia indyjska', field_type: 9)
  FieldOfStudy.create(name: 'Fizyka', field_type: 5)
  
# HighSchool samples
HighSchool.create(name: 'II Liceum Ogólnokształcące im. Hugona Kołłątaja w Wałbrzychu', city: 'Wałbrzych', school_type: 0)
HighSchool.create(name: 'XVI Liceum Ogólnokształcące im. Stefana Batorego w Białymstoku', city: 'Białystok', school_type: 0)
HighSchool.create(name: 'Technikum Komputerowe w Świdnicy', city: 'Świdnica', school_type: 1)
HighSchool.create(name: 'Technikum Energetyczne w Wałbrzychu', city: 'Wałbrzych', school_type: 1)
HighSchool.create(name: 'I Liceum Ogólnokształcące im. Józefa Piłsudskiego w Krotoszynie', city: 'Krotoszyn', school_type: 0)

# Academy samples
Academy.create(name: 'Uniwersytet Wrocławski', city: 'Wrocław', academy_type: 0)
Academy.create(name: 'Politechnika Opolska', city: 'Opole', academy_type: 1)
Academy.create(name: 'Akademia Sztuk Pięknych', city: 'Wrocław', academy_type: 4)
Academy.create(name: 'Uniwersytet Medyczny w Łodzi', city: 'Łódź', academy_type: 3)
Academy.create(name: 'Uniwersytet Przyrodniczy w Lublinie', city: 'Lublin', academy_type: 5)

# MaturaSubject samples
MaturaSubject.create(name: 'Biologia', subject_type: 1)
MaturaSubject.create(name: 'Chemia', subject_type: 1)
MaturaSubject.create(name: 'Filozofia', subject_type: 0)
MaturaSubject.create(name: 'Fizyka', subject_type: 1)
MaturaSubject.create(name: 'Geografia', subject_type: 1)
MaturaSubject.create(name: 'Historia', subject_type: 0)
MaturaSubject.create(name: 'Historia muzyki', subject_type: 0)
MaturaSubject.create(name: 'Historia sztuki', subject_type: 0)
MaturaSubject.create(name: 'Informatyka', subject_type: 1)
MaturaSubject.create(name: 'Język łaciński i kultura antyczna', subject_type: 0)
MaturaSubject.create(name: 'Język mniejszości etnicznej', subject_type: 0)
MaturaSubject.create(name: 'Język mniejszości narodowej', subject_type: 0)
MaturaSubject.create(name: 'Język regionalny', subject_type: 0)
MaturaSubject.create(name: 'Matematyka', subject_type: 1)
MaturaSubject.create(name: 'Język polski', subject_type: 0)
MaturaSubject.create(name: 'Wiedza o społeczeństwie', subject_type: 0)
MaturaSubject.create(name: 'Język angielski', subject_type: 0)
MaturaSubject.create(name: 'Język francuski', subject_type: 0)
MaturaSubject.create(name: 'Język hiszpański', subject_type: 0)
MaturaSubject.create(name: 'Język rosyjski', subject_type: 0)
MaturaSubject.create(name: 'Język włoski', subject_type: 0)

# Field Details
  # Uniwersytet Wrocławski
FieldDetail.create(field_of_study_id: 1,
                  recrutation_formula: '[(Biologia_Pp*0.5)|(Biologia_Pr*1.0)|(Chemia_Pp*0.5)|(Chemia_Pr*1.0)|(Fizyka_Pp*0.5)|(Fizyka_Pr*1.0)|(Informatyka_Pp*0.5)|(Informatyka_Pr*1.0)|(Matematyka_Pp*0.5)|(Matematyka_Pr*1.0)]+[(Biologia_Pp*0.5)|(Biologia_Pr*1.0)|(Chemia_Pp*0.5)|(Chemia_Pr*1.0)|(Fizyka_Pp*0.5)|(Fizyka_Pr*1.0)|(Informatyka_Pp*0.5)|(Informatyka_Pr*1.0)|(Matematyka_Pp*0.5)|(Matematyka_Pr*1.0)]+[(Język angielski_Pp*0.2)|(Język niemiecki_Pp*0.2)|(Język francuski_Pp*0.2)|(Język hiszpański_Pp*0.2)|(Język rosyjski_Pp*0.2)|(Język włoski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język niemiecki_Pr*0.4)|(Język francuski_Pr*0.4)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pr*0.4)|(Język włoski_Pr*0.4)]',
                  academy_id: 1,
                  students_limit: 48)
FieldDetail.create(field_of_study_id: 2,
                    recrutation_formula: '[]',
                    academy_id: 1,
                    students_limit: 30)
FieldDetail.create(field_of_study_id: 3,
                    recrutation_formula: '[(Język polski_Pp*0.25)|(Język polski_Pr*0.5)|(Matematyka_Pp*0.25)|(Matematyka_Pr*0.5)|(Geografia_Pp*0.25)|(Geografia_Pr*0.5)]+[(Historia_Pp*0.5)|(Historia_Pr*1)]+[(Język angielski_Pp*0.2)|(Język niemiecki_Pp*0.2)|(Język francuski_Pp*0.2)|(Język hiszpański_Pp*0.2)|(Język rosyjski_Pp*0.2)|(Język włoski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język niemiecki_Pr*0.4)|(Język francuski_Pr*0.4)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pr*0.4)|(Język włoski_Pr*0.4)][(Wiedza o społeczeństwie_Pp*0.5)|(Wiedza o społeczeństwie_Pr*1)]',
                    academy_id: 1,
                    students_limit: 80)
FieldDetail.create(field_of_study_id: 4,
                    recrutation_formula: '[(Geografia_Pp*0.5)|(Geografia_Pr*1)]+[(Biologia_Pp*0.5)|(Biologia_Pr*1)|(Fizyka_Pp*0.5)|(Fizyka_Pr*1)|(Chemia_Pp*0.5)|(Chemia_Pr*1)|(Historia_Pp*0.5)|(Historia_Pr*1)|(Matematyka_Pp*0.5)|(Matematyka_Pr*1)|(Wiedza o społeczeństwie_Pp*0.5)|(Wiedza o społeczeństwie_Pr*1)]+[(Język angielski_Pp*0.2)|(Język niemiecki_Pp*0.2)|(Język francuski_Pp*0.2)|(Język hiszpański_Pp*0.2)|(Język rosyjski_Pp*0.2)|(Język włoski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język niemiecki_Pr*0.4)|(Język francuski_Pr*0.4)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pr*0.4)|(Język włoski_Pr*0.4)]',
                    academy_id: 1,
                    students_limit: 65)
FieldDetail.create(field_of_study_id: 5,
                    recrutation_formula: '[(Język angielski_Pp*0.2)|(Język niemiecki_Pp*0.2)|(Język francuski_Pp*0.2)|(Język hiszpański_Pp*0.2)|(Język rosyjski_Pp*0.2)|(Język włoski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język niemiecki_Pr*0.4)|(Język francuski_Pr*0.4)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pr*0.4)|(Język włoski_Pr*0.4)][(Biologia_Pp*0.5)|(Biologia_Pr*1)|(Chemia_Pp*0.5)|(Chemia_Pr*1)|(Matematyka_Pp*0.5)|(Matematyka_Pr*1)|(Fizyka_Pp*0.5)|(Fizyka_Pr*1)]+[(Biologia_Pp*0.5)|(Biologia_Pr*1)|(Chemia_Pp*0.5)|(Chemia_Pr*1)|(Matematyka_Pp*0.5)|(Matematyka_Pr*1)|(Fizyka_Pp*0.5)|(Fizyka_Pr*1)]',
                    academy_id: 1,
                    students_limit: 60)
FieldDetail.create(field_of_study_id: 6,
                    recrutation_formula: '[(Język angielski_Pp*0.5)|(Język niemiecki_Pp*0.5)|(Język francuski_Pp*0.5)|(Język hiszpański_Pp*0.5)|(Język rosyjski_Pp*0.5)|(Język włoski_Pp*0.5)|(Język angielski_Pr*1)|(Język niemiecki_Pr*1)|(Język francuski_Pr*1)|(Język hiszpański_Pr*1)|(Język rosyjski_Pr*1)|(Język włoski_Pr*1)][( 0_Pp*0.5)|( 0_Pr*)|(25_Pp*0.5)|(25_Pr*)]+[(Język polski _Pp*0.5)|(Język polski _Pr*1)]',
                    academy_id: 1,
                    students_limit: 80)
FieldDetail.create(field_of_study_id: 7,
                    recrutation_formula: '[(Biologia_Pp*0)|(Biologia_Pr*0.5)|(Chemia_Pp*0)|(Chemia_Pr*0.5)|(Geografia_Pp*0)|(Geografia_Pr*0.5)|(  informatyka_Pp*0)|(  informatyka_Pr*0.5)]+[(Fizyka_Pp*0)|(Fizyka_Pr*1.5)]+[(Język angielski_Pp*0.2)|(Język niemiecki_Pp*0.2)|(Język francuski_Pp*0.2)|(Język hiszpański_Pp*0.2)|(Język rosyjski_Pp*0.2)|(Język włoski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język niemiecki_Pr*0.4)|(Język francuski_Pr*0.4)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pr*0.4)|(Język włoski_Pr*0.4)][(Matematyka_Pp*0.5)|(Matematyka_Pr*1.5)]',
                    academy_id: 1,
                    students_limit: 50)
FieldDetail.create(field_of_study_id: 8,
                    recrutation_formula: '[(Biologia_Pp*0.5)|(Biologia_Pr*1)|(Chemia_Pp*0.5)|(Chemia_Pr*1)|(Matematyka_Pp*0.5)|(Matematyka_Pr*1)|(Fizyka_Pp*0.5)|(Fizyka_Pr*1)]+[(Biologia_Pp*0.5)|(Biologia_Pr*1)|(Chemia_Pp*0.5)|(Chemia_Pr*1)|(Matematyka_Pp*0.5)|(Matematyka_Pr*1)|(Fizyka_Pp*0.5)|(Fizyka_Pr*1)]+[(Język angielski_Pp*0.2)|(Język niemiecki_Pp*0.2)|(Język francuski_Pp*0.2)|(Język hiszpański_Pp*0.2)|(Język rosyjski_Pp*0.2)|(Język włoski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język niemiecki_Pr*0.4)|(Język francuski_Pr*0.4)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pr*0.4)|(Język włoski_Pr*0.4)]',
                    academy_id: 1,
                    students_limit: 45)
FieldDetail.create(field_of_study_id: 9,
                    recrutation_formula: '[(Język angielski _Pp*0.5)|(Język angielski _Pr*1)]+[(Język polski _Pp*0.5)|(Język polski _Pr*1)]+[(Język łaciński i kultura antyczna_Pp*0)|(Język łaciński i kultura antyczna_Pr*1.5)]+[(Dowolny przedmiot  inny niż wymienione w tabeli_Pp*0.2)|(Dowolny przedmiot  inny niż wymienione w tabeli_Pr*0.4)]+[(Język angielski_Pp*0.25)|(Język niemiecki_Pp*0.25)|(Język francuski_Pp*0.25)|(Język hiszpański_Pp*0.25)|(Język rosyjski_Pp*0.25)|(Język włoski_Pp*0.25)|(Język angielski_Pr*0.5)|(Język niemiecki_Pr*0.5)|(Język francuski_Pr*0.5)|(Język hiszpański_Pr*0.5)|(Język rosyjski_Pr*0.5)|(Język włoski_Pr*0.5)]',
                    academy_id: 1,
                    students_limit: 30)
FieldDetail.create(field_of_study_id: 10,
                    recrutation_formula: '[(Fizyka_Pp*0)|(Fizyka_Pr*1.5)]+[(Matematyka_Pp*0.5)|(Matematyka_Pr*1.5)]+[(Chemia_Pp*0)|(Chemia_Pr*0.5)|(Geografia_Pp*0)|(Geografia_Pr*0.5)|(Informatyka_Pp*0)|(Informatyka_Pr*0.5)|(Biologia_Pp*0)|(Biologia_Pr*0.5)]+[(Język angielski_Pp*0.2)|(Język niemiecki_Pp*0.2)|(Język francuski_Pp*0.2)|(Język hiszpański_Pp*0.2)|(Język rosyjski_Pp*0.2)|(Język włoski_Pp*0.2)|(Język angielski_Pr*0.4)|(Język niemiecki_Pr*0.4)|(Język francuski_Pr*0.4)|(Język hiszpański_Pr*0.4)|(Język rosyjski_Pr*0.4)|(Język włoski_Pr*0.4)]',
                    academy_id: 1,
                    students_limit: 80)
