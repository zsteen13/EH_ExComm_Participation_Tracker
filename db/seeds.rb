# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "date"


# Admin and non Admin users for rspec and capybara testing
users = User.create!(uin: 11111111, first_name: 'Non Admin', last_name: 'Test', email: 'nonadmintest@gmail.com', committee: 'internal', subcommittee: 'None', admin: false, total_points:0, event_points:0, meeting_points:0, misc_points:0)
users = User.create!(uin: 22222222, first_name: 'Admin', last_name: 'Test', email: 'admintest@gmail.com', committee: 'internal', subcommittee: 'None', admin: true, total_points:0, event_points:0, meeting_points:0, misc_points:0)
users = User.create!(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points:0, event_points:0, meeting_points:0, misc_points:0, admin: true)
users = User.create!(uin: 123456789, first_name: 'first', last_name: 'last', email: 'test@gmail.com', committee: 'internal', subcommittee: 'something', total_points:0, event_points:0, meeting_points:0, misc_points:0, admin: true)
users = User.create!(uin: 1, first_name: 'trev', last_name: 'moore', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points:0, event_points:0, meeting_points:0, misc_points:0, admin: true)

Activity.create(name: "General Meeting", _type: "Meeting", date: DateTime.new(2020, 9, 15, 7, 0, 0, Rational(-5, 24)), point_value: 10, description: "First General Meeting", num_rsvp: 0)
Activity.create(name: "Canes Profit Share", _type: "Fundraiser", date: DateTime.new(2020, 10, 01, 5, 0, 0, Rational(-5, 24)), point_value: 8, description: "Meet and greet for the new members", num_rsvp: 0)


UserToActivity.create(uin: 123456789, activity_id: 3)
UserToActivity.create(uin: 123456789, activity_id: 4)
UserToActivity.create(uin: 000000000, activity_id: 3)