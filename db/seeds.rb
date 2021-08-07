require 'faker'

p 'Creating Articles'
30.times do
  Article.create(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(number: 8).join("\n"),
    private: Faker::Boolean.boolean
  )
end

p 'Creating Users'
10.times do
  User.create(
    email: Faker::Internet.unique.email,
    password: '123456',
    password_confirmation: '123456'
  )
end
