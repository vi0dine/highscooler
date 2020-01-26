NUMBER_OF_FIELDS = 10
NUMBER_OF_ACADEMIES = 10

User.create(username: 'schoolboy', email: "schoolboy@example.com", role: "schoolboy", password: "test1234")
User.create(username: 'student', email: "student@example.com", role: "student", password: "test1234")
User.create(username: 'partner', email: "partner@example.com", role: "partner", password: "test1234")
User.create(username: 'admin', email: "admin@example.com", role: "admin", password: "test1234")

NUMBER_OF_FIELDS.times do
  FieldOfStudy.create!(
      name: "#{Faker::Educator.course_name}",
      description: Faker::Lorem.sentences
  )
end

NUMBER_OF_ACADEMIES.times do
  Academy.create!(
      name: "#{Faker::Educator.university}",
      description: Faker::Lorem.sentences,
      city: Faker::Address.city
  )
end