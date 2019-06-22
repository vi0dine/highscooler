# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# FieldOfStudie samples
FieldOfStudy.create(name: 'Lekarski', field_type: 4)
FieldOfStudy.create(name: 'Informatyka', field_type: 3)
FieldOfStudy.create(name: 'Prawo', field_type: 0)
FieldOfStudy.create(name: 'Matematyka', field_type: 3)
FieldOfStudy.create(name: 'Socjologia', field_type: 1)
FieldOfStudy.create(name: 'Behawiorystyka zwierząt', field_type: 5)

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
MaturaSubject.create(name: 'Matematyka', subject_type: 1)
MaturaSubject.create(name: 'Język Polski', subject_type: 0)
MaturaSubject.create(name: 'Język Angielski', subject_type: 0)
MaturaSubject.create(name: 'Biologia', subject_type: 1)
MaturaSubject.create(name: 'Chemia', subject_type: 1)
MaturaSubject.create(name: 'Fizyka', subject_type: 1)
MaturaSubject.create(name: 'Informatyka', subject_type: 1)
MaturaSubject.create(name: 'WOS', subject_type: 0)
MaturaSubject.create(name: 'Historia', subject_type: 0)

# FieldDetail samples
FieldDetail.create(students_limit: 520,
                   recrutation_formula: '(Biologia_Pr|Chemia_Pr|Matematyka_Pr|Fizyka_Pr)*2+(Biologia_Pr|Chemia_Pr|Matematyka_Pr|Fizyka_Pr)*2',
                   minimal_points: 320,
                   academy_id: 4,
                   field_of_study_id: 1)
FieldDetail.create(recrutation_formula: '2*(Chemia_Pr|Fizyka_Pr|Informatyka_Pr|Matematyka_Pr)|0.5*(Język Polski_Pr) + 2*(Chemia_Pr|Fizyka_Pr|Informatyka_Pr|Matematyka_Pr) + 0.5*(Język Angielski_Pr)',
                   academy_id: 2,
                   field_of_study_id: 2)
FieldDetail.create(students_limit: 200,
                   recrutation_formula: '(Historia_Pr|Matematyka_Pr)*(0.5|1)+(WOS_Pr|Język Polski_Pr|Geografia_Pr)*(0.25|0.5)+(Język Angielski_Pr)*(0.2|0.4)',
                   academy_id: 1,
                   field_of_study_id: 3)