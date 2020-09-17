# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = User.create(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', admin: true)
users = User.create(uin: 123456789, first_name: 'first', last_name: 'last', email: 'test@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 10, admin: true)