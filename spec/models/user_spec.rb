require 'rails_helper'

RSpec.describe User, :type => :model do
  it("should only except ints in the uin, total_points, event_points, and misc points") do

    users = User.new(uin: "00000a0000", first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: nil, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: nil, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: "a", event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: nil, meeting_points: 0, event_points: "3la", misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be true
  end
  it("should have a value email") do
    users = User.new(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be true
  end
  it("should have the required fields") do
    users = User.new( first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: 000000000, last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: 000000000, first_name: 'Zachary', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be true  
  end
  it("should valid determine if a boolean field is valid") do
    users = User.new(uin: 000000000, first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: "here")

    expect(users.valid?).to be false 
  end
end
