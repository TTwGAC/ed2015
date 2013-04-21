# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Skip validation because this is a reserved team name
game_control = Team.new name: "Game Control", slogan: "Keeping you honest since 2014"
game_control.save! validate: false

# Skip validation because this is a reserved team name
observers = Team.new name: "Observers", slogan: '"I like to watch"'
observers.save! validate: false

ben = User.create! first_name: "Ben",
  last_name: "Klang",
  nickname: "Leon",
  email: "ben@alkaloid.net",
  password: "abcdefg" # CHANGE THIS!
ben.team = game_control
ben.save!
ben.confirm!

alicia = User.create! first_name: "Alicia",
  last_name: "Cardillo",
  nickname: "Leonetta",
  email: "alicia.cardillo@gmail.com",
  password: "abcdefg" # CHANGE THIS!
alicia.team = game_control
alicia.save!
alicia.confirm!
