# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# #
# # Examples:
# #
# #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
# #   Mayor.create(name: 'Emanuel', city: cities.first)
# # User.create!(name:  "Example User",
# #              email: "example@railstutorial.org",
# #              password:              "foobar",
# #              password_confirmation: "foobar",
# #              admin:     true,
# #              activated: true,
# #              activated_at: Time.zone.now)


20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
              email: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)



  Language.create!(language: "English",
  				   level: 5 ,
  				   user_id: n + 1)
  
end

#languages

20.times do |n|
  language  = "English" 
  level = 5
  users = User.all

  users.each do |user|

  user.passive_relationships.build(language: language, level: level).save



  end
  
end





# #micropost
# # users = User.order(:created_at).take(6)
# # 50.times do
# #   content = Faker::Lorem.sentence(5)
# #   users.each { |user| user.microposts.create!(content: content) }
# # end


# # # Following reltionships
# # users = User.all
# # user = users.first
# # following = users[2..50]
# # followers = users[3..40]
# # following.each {|followed| user.follow(followed)}
# # followers.each {|follower| follower.follow(user)}