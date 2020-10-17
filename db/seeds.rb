# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "date"

# Admin and non Admin users for rspec and capybara testing
users1 = User.create!(uin: '11111111', password_digest: BCrypt::Password.create('Test'), first_name: 'Non Admin', last_name: 'Test', email: 'nonadmintest@gmail.com', committee: "Internal", subcommittee: 0, admin: false, total_points:0, event_points:0, meeting_points:0, misc_points:0)

users2 = User.create!(uin: '22222222',  password_digest: BCrypt::Password.create('Test'), first_name: 'Admin', last_name: 'Test', email: 'admintest@gmail.com', committee: "Internal", subcommittee: 3, admin: true, total_points:0, event_points:0, meeting_points:0, misc_points:0)

users3 = User.create!(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: "External", subcommittee: 0, total_points:0, event_points:0, meeting_points:0, misc_points:0, admin: true)

users4 = User.create!(uin: '123456789', password_digest: BCrypt::Password.create('Test'), first_name: 'first', last_name: 'last', email: 'test@gmail.com', committee: "Operations", subcommittee: 1, total_points:0, event_points:0, meeting_points:0, misc_points:0, admin: true)

users5 = User.create!(uin: '000000001', password_digest: BCrypt::Password.create('Test'), first_name: 'trev', last_name: 'moore', email: 'zsteen13@gmail.com', committee: "Internal", subcommittee: 2, total_points:0, event_points:0, meeting_points:0, misc_points:0, admin: true)

activity1 = Activity.create(name: "Meet and Greet", _type: "Event", date: DateTime.new(2020, 8, 23, 11, 0, 0, Rational(-5, 24)), point_value: 4, description: "Meet and greet for the new members", num_rsvp: 0)

activity2 = Activity.create(name: "General Meeting", _type: "Meeting", date: DateTime.new(2020, 9, 15, 7, 0, 0, Rational(-5, 24)), point_value: 10, description: "First General Meeting", num_rsvp: 0)

activity3 = Activity.create(name: "Canes Profit Share", _type: "Misc", date: DateTime.new(2020, 10, 01, 5, 0, 0, Rational(-5, 24)), point_value: 8, description: "Meet and greet for the new members", num_rsvp: 0)

UserToActivity.create(uin: users1.uin, activity_id: activity1.id)
UserToActivity.create(uin: users2.uin, activity_id: activity1.id)

UserToActivity.create(uin: users1.uin, activity_id: activity2.id)
UserToActivity.create(uin: users3.uin, activity_id: activity2.id)
UserToActivity.create(uin: users4.uin, activity_id: activity2.id)

UserToActivity.create(uin: users2.uin, activity_id: activity3.id)
UserToActivity.create(uin: users3.uin, activity_id: activity3.id)
UserToActivity.create(uin: users5.uin, activity_id: activity2.id)

UserKey.create!(user_id: 1, key: 'testkey')

# These seeds cannot be deleted/modified, they are necessary for reference operations
Privledge.create(privledge_id: 0, privledge: 'User')
Privledge.create(privledge_id: 1, privledge: 'Admin')
Privledge.create(privledge_id: 2, privledge: 'Super-Admin')

Committee.create(committee_id: 0, committee: 'Internal', email: 'None')
Committee.create(committee_id: 1, committee: 'External', email: 'None')
Committee.create(committee_id: 2, committee: 'Operations', email: 'None')

Subcommittee.create(subcommittee_id: 0, subcommittee: 'Community Building', committee: 0)
Subcommittee.create(subcommittee_id: 1, subcommittee: 'Research and Technology', committee: 0)
Subcommittee.create(subcommittee_id: 2, subcommittee: 'Professional Development', committee: 1)
Subcommittee.create(subcommittee_id: 3, subcommittee: 'Service', committee: 1)
