# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it('should only accept ints in the uin, total_points, event_points, and misc points') do
    users = User.new(uin: '00000a0000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false


    users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: "a", event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: nil, meeting_points: 0, event_points: '3la', misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be true
  end

  it('should have a valid email') do
    users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be true
  end

  it('should have the required fields') do
    users = User.new(password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: '00000000', first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)

    expect(users.valid?).to be false

    users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)
    expect(users.valid?).to be true
  end

  describe 'should default the admin field to false' do
    it 'when admin is "a"' do
      users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: 'a')
      expect(users.admin).to be false
    end

    it 'when admin is "3"' do
      users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: '3')
      expect(users.admin).to be false
    end

    it 'when admin is "here"' do
      users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: 'here')
      expect(users.admin).to be false
    end

    it 'when admin is false' do
      users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: false)
      expect(users.admin).to be false
    end

    it 'when admin is true' do
      users = User.new(uin: '000000000', password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)
      expect(users.admin).to be true
    end
  end

  describe 'should default the admin field to false' do
    it 'when admin is "a"' do
      users = User.new(uin: '000000000', first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: 'a')
      expect(users.admin).to be false
    end

    it 'when admin is "3"' do
      users = User.new(uin: '000000000', first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: '3')
      expect(users.admin).to be false
    end

    it 'when admin is "here"' do
      users = User.new(uin: '000000000', first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: 'here')
      expect(users.admin).to be false
    end

    it 'when admin is false' do
      users = User.new(uin: '000000000', first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: false)
      expect(users.admin).to be false
    end

    it 'when admin is true' do
      users = User.new(uin: '000000000', first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)
      expect(users.admin).to be true
    end
  end
  describe 'uin should be 9 digits' do
    it 'should expect user with uin eql to 9 digits' do
      user = User.new(uin: "000000000",  password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com')
      expect(user.valid?).to eq true
    end

    it 'should not expect user with uin not eql to 9 digits' do
      user = User.new(uin: "0000000000",  password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com')
      expect(user.valid?).to eq false

      user = User.new(uin: "000000",  password_digest: BCrypt::Password.create('Test'), first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com')
      expect(user.valid?).to eq false
    end
  end

  describe 'display points' do
    it 'returns value for all point types when methods called' do
      user = User.new(uin: '000000000', first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', total_points: 0, meeting_points: 1, event_points: 2, misc_points: 3, admin: true)
      expect(user.display_total_points).to eq(0)
      expect(user.display_meeting_points).to eq(1)
      expect(user.display_event_points).to eq(2)
      expect(user.display_misc_points).to eq(3)
    end

    it 'returns 0 for all point types when methods called when unassigned' do
      user = User.new(uin: '000000000', first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'internal', subcommittee: 'something', admin: true)
      expect(user.display_total_points).to eq(0)
      expect(user.display_meeting_points).to eq(0)
      expect(user.display_event_points).to eq(0)
      expect(user.display_misc_points).to eq(0)
    end
  end

  describe 'properly display committee/subcommittee' do
    it 'returns correct committee/subcommittee name for a user' do
      user = User.new(uin: '000000000', first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'Internal', subcommittee: 'Community Building', admin: true)
      expect(user.display_committee).to eq('Internal')
      expect(user.display_subcommittee).to eq('Community Building')
    end

    it 'returns explanation for committee/subcommittee name for a user if unassigned' do
      user = User.new(uin: '000000000', first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', admin: true)
      expect(user.display_committee).to eq('No assigned committee')
      expect(user.display_subcommittee).to eq('No assigned subcommittee')
    end
  end

  describe '#to_s' do
    it 'returns a string version of a users profile' do
      user = User.new(uin: '000000000', first_name: 'Zachary', last_name: 'Steen', email: 'zsteen13@gmail.com', committee: 'Internal', subcommittee: 'Community Building', total_points: 0, meeting_points: 0, event_points: 0, misc_points: 0, admin: true)
      expect(user.to_s).to eq('uin: 000000000 first_name: Zachary last_name Steen email: zsteen13@gmail.com committee: Internal subcommittee: Community Building total_point: 0 meeting_points: 0 event_points: 0 misc_points 0 admin: true'+"\n")
    end
  end
end
