# frozen_string_literal: true

require 'rails_helper'
require 'csv'

RSpec.describe BulkAddUsersHelper, type: :helper do
  it('should determine whether the number of columns is correct') do
    filename = Rails.root.join('spec', 'data', 'bulk_add_users_wrong.csv')
    valid, row, col = BulkAddUsersHelper.check_num_cols(filename)
    expect(valid).to be false
    expect(row).to be 2
    expect(col).to be 10

    filename = Rails.root.join('spec', 'data', 'bulk_add_users_correct.csv')
    valid, _row, _col = BulkAddUsersHelper.check_num_cols(filename)
    expect(valid).to be true
  end
  it('should be able to determine whether the input csv is value or not') do
    filename = Rails.root.join('spec', 'data', 'bulk_add_users_wrong_2.csv')
    _users, valid = BulkAddUsersHelper.parse_data(filename)
    expect(valid).to be false

    filename = Rails.root.join('spec', 'data', 'bulk_add_users_wrong_3.csv')
    _users, valid = BulkAddUsersHelper.parse_data(filename)
    expect(valid).to be false

    filename = Rails.root.join('spec', 'data', 'bulk_add_users_wrong_4.csv')
    _users, valid = BulkAddUsersHelper.parse_data(filename)
    expect(valid).to be false

    filename = Rails.root.join('spec', 'data', 'bulk_add_users_correct.csv')
    _users, valid = BulkAddUsersHelper.parse_data(filename)
    expect(valid).to be true
  end
  it 'should be false' do
    filename = Rails.root.join('spec', 'data', 'bulk_add_users_wrong_6.csv')
    users, _valid = BulkAddUsersHelper.parse_data(filename)
    expect(users[0].admin).to be false
  end
end
