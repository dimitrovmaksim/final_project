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
  title: "Test Article 1",
  text: "Test 1",
  created_at: "2015-01-01 10:00:00",
  user_id: "1")

Article.create(
  title: "Test Article 2",
  text: "Test 2",
  created_at: "2015-01-02 10:00:00",
  user_id: "1")

Article.create(
  title: "Test Article 3",
  text: "Test 3",
  created_at: "2015-01-03 10:00:00",
  user_id: "1")

Article.create(
  title: "Test Article 4",
  text: "Test 4",
  created_at: "2015-01-04 10:00:00",
  user_id: "1")

Article.create(
  title: "Test Article 5",
  text: "Test 5",
  created_at: "2015-01-05 10:00:00",
  user_id: "1")

Article.create(
  title: "Test Article 6",
  text: "Test 6",
  created_at: "2015-01-06 10:00:00",
  user_id: "1")

Article.create(
  title: "Test Article 7",
  text: "Test 7",
  created_at: "2015-02-01 10:00:00",
  user_id: "1")

Article.create(
  title: "Test Article 8",
  text: "Test 8",
  created_at: "2015-02-02 10:00:00",
  user_id: "1")

Article.create(
  title: "Test Article 9",
  text: "Test 9",
  created_at: "2015-02-03 10:00:00",
  user_id: "1")

Article.create(
  title: "Test Article 10",
  text: "Test 10",
  created_at: "2015-02-04 10:00:00",
  user_id: "1")

Article.create(
  title: "Test Article 11",
  text: "Test 11",
  created_at: "2015-02-05 10:00:00",
  user_id: "1")

Article.create(
  title: "Test Article 12",
  text: "Test 12",
  created_at: "2015-03-01 10:00:00",
  user_id: "1")
