require 'faker'
require 'random_data'

5.times do
  User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length = 6, max_length = 16)
  )
end
users = User.all

User.create!(
  email: 'night1300013@gmail.com',
  password: 111111,
  role: 'admin'
)

User.create!(
  email: 'night1300013@hotmail.com',
  password: 111111,
  role: 'standard'
)

50.times do
  wiki = Wiki.create!(
    user: users.sample,
    title: Faker::Commerce.product_name,
    body: Faker::Lorem.paragraphs.join(' ')
  )

  wiki.update_attribute(:created_at, Faker::Time.backward(365, :evening))
end
wikis = Wiki.all



puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
