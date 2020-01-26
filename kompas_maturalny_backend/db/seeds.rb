NUMBER_OF_FIELDS = 10
NUMBER_OF_ACADEMIES = 10
NUMBER_OF_MATURA_RESULTS = 3

User.create(username: 'schoolboy', email: "schoolboy@example.com", role: "schoolboy", password: "test1234")
User.create(username: 'student', email: "student@example.com", role: "student", password: "test1234")
User.create(username: 'partner', email: "partner@example.com", role: "partner", password: "test1234")
User.create(username: 'admin', email: "admin@example.com", role: "admin", password: "test1234")

User.all.each do |user|
  NUMBER_OF_MATURA_RESULTS.times do
    user.matura_results << MaturaResult.create(matura_subject: MaturaSubject.all.sample, result: Faker::Base.rand_in_range(0, 100))
  end
end

NUMBER_OF_FIELDS.times do
  FieldOfStudy.create!(
      name: "#{Faker::Educator.course_name}",
      description: Faker::Lorem.sentences
  )
end

NUMBER_OF_ACADEMIES.times do |i|
  Academy.create!(
      name: "#{Faker::Educator.university}#{i}",
      description: Faker::Lorem.sentences,
      city: Faker::Address.city
  )
end

MaturaSubject.create(name: 'Chemia', subject_type: 'sciences')
MaturaSubject.create(name: 'Biologia', subject_type: 'sciences')
MaturaSubject.create(name: 'Fizyka', subject_type: 'sciences')
MaturaSubject.create(name: 'Geografia', subject_type: 'sciences')
MaturaSubject.create(name: 'Matematyka', subject_type: 'sciences')
MaturaSubject.create(name: 'Angielski', subject_type: 'humanities')
MaturaSubject.create(name: 'Niemiecki', subject_type: 'humanities')
MaturaSubject.create(name: 'Francuski', subject_type: 'humanities')