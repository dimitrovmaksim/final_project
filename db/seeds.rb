# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
  email: "admin@admin.com",
  password: "admin1",
  password_confirmation: "admin1",
  user_name: "admin",
  admin: true)

Article.create(
  title: "Testing Archive functionality 1",
  text: "Testing Archive functionality 1",
  created_at: "2014-01-01 10:00:00",
  user_id: "1")

Article.create(
  title: "Testing Archive functionality 2",
  text: "Testing Archive functionality 2",
  created_at: "2015-01-01 10:00:00",
  user_id: "1")
