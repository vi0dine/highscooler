NUMBER_OF_FIELDS = 50
NUMBER_OF_ACADEMIES = 40
NUMBER_OF_FIELDS_ON_ACADEMY = 35
NUMBER_OF_MATURA_RESULTS = 5

puts "Seeding database"
puts "Seeding test users"
User.create(username: 'schoolboy', email: "schoolboy@example.com", role: "schoolboy", password: "test1234")
User.create(username: 'student', email: "student@example.com", role: "student", password: "test1234")
User.create(username: 'partner', email: "partner@example.com", role: "partner", password: "test1234")
User.create(username: 'admin', email: "admin@example.com", role: "admin", password: "test1234")

puts "Seeding matura subjects"
MaturaSubject.create(name: 'Chemia', subject_type: 'sciences')
MaturaSubject.create(name: 'Biologia', subject_type: 'sciences')
MaturaSubject.create(name: 'Fizyka', subject_type: 'sciences')
MaturaSubject.create(name: 'Geografia', subject_type: 'sciences')
MaturaSubject.create(name: 'Matematyka', subject_type: 'sciences')
MaturaSubject.create(name: 'Angielski', subject_type: 'humanities')
MaturaSubject.create(name: 'Niemiecki', subject_type: 'humanities')
MaturaSubject.create(name: 'Francuski', subject_type: 'humanities')

User.all.each do |user|
  NUMBER_OF_MATURA_RESULTS.times do |i|
    puts "Seeding matura results #{i}/#{NUMBER_OF_MATURA_RESULTS}"
    user.matura_results << MaturaResult.create(matura_subject: MaturaSubject.all.sample, result: Faker::Base.rand_in_range(0, 100))
  end
end

NUMBER_OF_FIELDS.times do |i|
  puts "Seeding fields of study #{i}/#{NUMBER_OF_FIELDS}"
  FieldOfStudy.create!(
      name: "#{Faker::Educator.course_name}",
      description: Faker::Lorem.paragraph(sentence_count: 10)
  )
end

NUMBER_OF_ACADEMIES.times do |i|
  puts "Seeding academies #{i}/#{NUMBER_OF_ACADEMIES}"
  academy = Academy.create!(
      name: "#{Faker::Educator.university}#{i}",
      description: Faker::Lorem.paragraph(sentence_count: 10),
      city: Faker::Address.city
  )

  NUMBER_OF_FIELDS_ON_ACADEMY.times do |i|
    puts "Seeding academy fields #{i}/#{NUMBER_OF_FIELDS_ON_ACADEMY}"
    AcademyField.create!(
        field_of_study: FieldOfStudy.all[i],
        academy: academy,
        recruitment_formula: "[(Chemia_Pr*2)|(Biologia_Pr*2)]+[(Fizyka_Pr*2)|(Matematyka_Pr*2]"
    )
  end
end