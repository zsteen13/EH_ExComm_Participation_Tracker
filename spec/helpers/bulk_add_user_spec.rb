require "rails_helper"
require "csv"

RSpec.describe BulkAddUsersHelper, :type => :helper do
  it("should determine whether the number of columns is correct") do
    filename = Rails.root.join("spec", "data", "bulk_add_users_wrong.csv")
    valid, row, col = BulkAddUsersHelper.checkNumColumns(filename)
    expect(valid).to be false
    expect(row).to eq 3
    expect(col).to eq 3

    filename = Rails.root.join("spec", "data", "bulk_add_users_correct.csv")
    valid, row, col = BulkAddUsersHelper.checkNumColumns(filename)
    expect(valid).to be true
  end
  it("should be able to determine whether the input csv is value or not") do
    filename = Rails.root.join("spec", "data", "bulk_add_users_wrong_2.csv")
    users, valid = BulkAddUsersHelper.parseData(filename)
    expect(valid).to be false

    filename = Rails.root.join("spec", "data", "bulk_add_users_wrong_3.csv")
    users, valid = BulkAddUsersHelper.parseData(filename)
    expect(valid).to be false

    filename = Rails.root.join("spec", "data", "bulk_add_users_wrong_4.csv")
    users, valid = BulkAddUsersHelper.parseData(filename)
    expect(valid).to be false

    filename = Rails.root.join("spec", "data", "bulk_add_users_correct.csv")
    users, valid = BulkAddUsersHelper.parseData(filename)
    expect(valid).to be true
  end
  it "should be false" do
    filename = Rails.root.join("spec", "data", "bulk_add_users_wrong_6.csv")
    users, valid = BulkAddUsersHelper.parseData(filename)
    expect(users[0].admin).to be false
  end
  it 'should be able handle a csv without optional values' do
    filename = Rails.root.join("spec", "data", "bulk_add_users_correct_2.csv")
    users, valid = BulkAddUsersHelper.parseData(filename)
    user = users[0]
    expect(user.uin).to eq "958285839"
    expect(user.first_name).to eq "trevor"
    expect(user.last_name).to eq "moore"
    expect(user.email).to eq "moore.trev@tamu.edu"
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
    filename = Rails.root.join("spec", "data", "bulk_add_users_correct_3.csv")
    users, valid = BulkAddUsersHelper.parseData(filename)
    expect(valid).to be true

    expect(users[0].committee).to eq nil
    expect(users[0].subcommittee).to eq nil

    expect(users[2].total_points).to eq 10

  end
end
