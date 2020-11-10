# frozen_string_literal: true

require 'rails_helper'
require 'csv'

RSpec.describe BulkAddUsersHelper, type: :helper do
  it('should determine whether the number of columns is correct') do
    filename = Rails.root.join('spec', 'data', 'bulk_add_users', 'bulk_add_users_wrong.csv')
    valid, row, col = BulkAddUsersHelper.check_num_columns(filename)
    expect(valid).to be false
    expect(row).to eq 3
    expect(col).to eq 3

    filename = Rails.root.join('spec', 'data', 'bulk_add_users', 'bulk_add_users_correct.csv')
    valid, _row, _col = BulkAddUsersHelper.check_num_columns(filename)
    expect(valid).to be true
  end
  it('should be able to determine whether the input csv is value or not') do
    filename = Rails.root.join('spec', 'data', 'bulk_add_users', 'bulk_add_users_wrong_2.csv')
    _users, valid = BulkAddUsersHelper.parse_data(filename)
    expect(valid).to be false

    filename = Rails.root.join('spec', 'data', 'bulk_add_users', 'bulk_add_users_wrong_3.csv')
    _users, valid = BulkAddUsersHelper.parse_data(filename)
    expect(valid).to be false

    filename = Rails.root.join('spec', 'data', 'bulk_add_users', 'bulk_add_users_wrong_4.csv')
    _users, valid = BulkAddUsersHelper.parse_data(filename)
    expect(valid).to be false

    filename = Rails.root.join('spec', 'data', 'bulk_add_users', 'bulk_add_users_correct.csv')
    _users, valid = BulkAddUsersHelper.parse_data(filename)
    expect(valid).to be true
  end

  it 'should be false' do
    filename = Rails.root.join('spec', 'data', 'bulk_add_users', 'bulk_add_users_wrong_6.csv')
    users, _valid = BulkAddUsersHelper.parse_data(filename)
    expect(users[0].admin).to be false
  end

  it 'should be able handle a csv without optional values' do
    filename = Rails.root.join('spec', 'data', 'bulk_add_users', 'bulk_add_users_correct_2.csv')
    users, valid = BulkAddUsersHelper.parse_data(filename)
    user = users[0]
    expect(user.uin).to eq '958285839'
    expect(user.first_name).to eq 'John'
    expect(user.last_name).to eq 'Doe'
    expect(user.email).to eq 'john@tamu.edu'
    expect(user.committee).to eq nil
    expect(user.subcommittee).to eq nil
    expect(user.total_points).to be 0
    expect(user.meeting_points).to be 0
    expect(user.event_points).to be 0
    expect(user.misc_points).to be 0
    expect(user.admin).to be false
    expect(valid).to be true
  end

  it 'should be able to handle a csv with some optional values' do
    filename = Rails.root.join('spec', 'data', 'bulk_add_users', 'bulk_add_users_correct_3.csv')
    users, valid = BulkAddUsersHelper.parse_data(filename)
    expect(valid).to be true

    expect(users[0].committee).to eq nil
    expect(users[0].subcommittee).to eq nil

    expect(users[2].total_points).to eq 0
  end

  it 'should be able to convert a committee name to the id' do
    Committee.create!(id: 9999, committee: 'Temp Committee', head_first_name: 'Sample_First', head_last_name: 'Sample_Last', email: 'example_email@tamu.edu', point_threshold: 101)

    id = BulkAddUsersHelper.committee_name_to_id 'Temp Committee'
    expect(id).to eq(9999)

    id = BulkAddUsersHelper.committee_name_to_id 'temp committee'
    expect(id).to eq(9999)
  end

  it 'should be able to convert a committee name to the id' do
    Subcommittee.create!(id: 9999, subcommittee: 'Temp Committee', committee: 1, point_threshold: 102)

    id = BulkAddUsersHelper.subcommittee_name_to_id 'Temp Committee'
    expect(id).to eq(9999)

    id = BulkAddUsersHelper.subcommittee_name_to_id 'temp committee'
    expect(id).to eq(9999)
  end

  it 'parsing should be able to convert committee and subcommittee name to id' do
    Committee.create!(id: 9999, committee: 'Temp Committee', head_first_name: 'Sample_First', head_last_name: 'Sample_Last', email: 'example_email@tamu.edu', point_threshold: 101)
    Subcommittee.create!(id: 9990, subcommittee: 'Temp Subcommittee', committee: 9999, point_threshold: 102)

    filename = Rails.root.join('spec', 'data', 'bulk_add_users', 'bulk_add_users_correct_4.csv')
    users, valid = BulkAddUsersHelper.parse_data(filename)
    user = users[0]
    puts

    expect(valid).to be true
    expect(user.committee).to eq('9999')
    expect(user.subcommittee).to eq('9990')
  end
end
