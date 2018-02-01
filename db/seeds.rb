require 'random_data'

5.times do
  User.create!(
    email: RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users = User.all

50.times do
  wiki = Wiki.create!(
    user: users.sample,
    title: RandomData.random_sentence,
    body: RandomData.random_paragraph
  )

  wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end
wikis = Wiki.all

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

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
