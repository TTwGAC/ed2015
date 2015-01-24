# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Clear out old data. Careful!!!!!
Team.delete_all
Player.delete_all

# Skip validation because this is a reserved team name
game_control = Team.new name: 'Game Control', slogan: 'Keeping you honest with threat of Burnination'
game_control.save! validate: false

# Skip validation because this is a reserved team name
observers = Team.new name: 'Observers', slogan: '"I like to watch"'
observers.save! validate: false

system = Player.new first_name: 'System',
  last_name: 'Player',
  email: 'noreply@gac2014.com',
  password: SecureRandom.hex(64),
  phone: '14045551234'
system.skip_confirmation!
system.save!

abby = Player.new first_name: "Abby",
  last_name: "Gaskins",
  nickname: "Brett Bretterson",
  email: "abby.gaskins@gmail.com",
  password: "abcdefg", # CHANGE THIS!
  phone: '14045551235'
abby.team = game_control
abby.skip_confirmation!
abby.save!

alex = Player.new first_name: "Alex",
  last_name: "Bowers",
  nickname: "woot",
  email: "alexandra.bowers@gmail.com",
  password: "abcdefg", # CHANGE THIS!
  phone: '14045551236'
alex.team = game_control
alex.skip_confirmation!
alex.save!
