# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "date"

# users = User.create(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', admin: true)
# users = User.create(uin: 123456789, first_name: 'first', last_name: 'last', email: 'test@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 10, admin: true)
# users = User.create(uin: 1, first_name: 'trev', last_name: 'moore', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', admin: true)

# Activity.create(name: "Meet and Greet", _type: "Social", date: DateTime.new(2020, 8, 23, 11, 0, 0, Rational(-5, 24)), point_value: 4, description: "Meet and greet for the new members", num_rsvp: 0)
Activity.create(name: "General Meeting", _type: "Meeting", date: DateTime.new(2020, 9, 15, 7, 0, 0, Rational(-5, 24)), point_value: 10, description: "First General Meeting", num_rsvp: 0)
Activity.create(name: "Canes Profit Share", _type: "Fundraiser", date: DateTime.new(2020, 10, 01, 5, 0, 0, Rational(-5, 24)), point_value: 8, description: "Meet and greet for the new members", num_rsvp: 0)

# UserToActivity.create(uin: 123456789, activity_id: 1)
# UserToActivity.create(uin: 000000000, activity_id: 1)
UserToActivity.create(uin: 123456789, activity_id: 3)
UserToActivity.create(uin: 123456789, activity_id: 4)
UserToActivity.create(uin: 000000000, activity_id: 3)
