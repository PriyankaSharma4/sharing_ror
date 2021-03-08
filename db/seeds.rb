# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


puts "-----User Created Start----------"


User.create!(email: "user1@yopmail.com", password: "12345678")
User.create!(email: "user2@yopmail.com", password: "12345678")

User.create!(email: "user3@yopmail.com", password: "12345678")

User.create!(email: "user4@yopmail.com", password: "12345678")

User.create!(email: "user5@yopmail.com", password: "12345678")

User.create!(email: "user6@yopmail.com", password: "12345678")

User.create!(email: "user7@yopmail.com", password: "12345678")

User.create!(email: "user8@yopmail.com", password: "12345678")




puts "-------User Created End---------"


puts "-----Location Created Start----------"


LocationShare.create!(user_id: 1, address: "St Petersburg, Russia", lat: 0.599310584e2, long: 0.303609097e2, is_public: false)

LocationShare.create!(user_id: 1, address: "Chittorgarh, Rajasthan, India", lat: 0.24879999e2, long: 0.74629997e2, is_public: true)


LocationShare.create!(user_id: 2, address: "Goregaon, Mumbai, Maharashtra, India", lat: 0.19155001e2, long: 0.72849998e2, is_public: true)

LocationShare.create!(user_id: 2, address: "Ranebennur, Karnataka, India", lat: 0.14623801e2, long: 0.75621788e2, is_public: true)


LocationShare.create!(user_id: 3, address: "Belgaum, Karnataka, India", lat: 0.15852792e2, long: 0.74498703e2, is_public: false)



puts "-------Location Created End---------"


SharedToOther.create!(location_share_id: 1, user_id: 2)
SharedToOther.create!(location_share_id: 1, user_id: 3)
SharedToOther.create!(location_share_id: 1, user_id: 4)

SharedToOther.create!(location_share_id: 3 ,user_id: 3)
SharedToOther.create!(location_share_id: 3, user_id: 1)

SharedToOther.create!(location_share_id: 5,user_id: 1)
SharedToOther.create!(location_share_id: 5,user_id: 2)



