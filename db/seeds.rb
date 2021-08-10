require 'faker'

p 'Creating Categories'
basic = Category.create(name: 'Basic', price: 300)
premium = Category.create(name: 'Premium', price: 300)

p 'Creating Articles'
30.times do
  Article.create(
    title: Faker::Book.title,
    body: Faker::Lorem.paragraphs(number: 8).join("\n"),
    private: Faker::Boolean.boolean,
    category: [basic, premium].sample
  )
end

p 'Creating Users'
User.create(
  email: 'test@email.com',
  password: '123456',
  password_confirmation: '123456'
)
10.times do
  User.create(
    email: Faker::Internet.unique.email,
    password: '123456',
    password_confirmation: '123456'
  )
end
