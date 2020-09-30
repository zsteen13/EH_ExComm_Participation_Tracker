require 'rails_helper'
require 'csv'

RSpec.describe BulkAddUsersHelper, :type => :helper do
    it("should determine whether the number of columns is correct") do
        filename = Rails.root.join('spec', 'data', "bulk_add_users_wrong.csv")
        res = BulkAddUsersHelper.checkNumColumns(filename)
        expect(res).to be false

        filename = Rails.root.join('spec', 'data', "bulk_add_users_correct.csv")
        res = BulkAddUsersHelper.checkNumColumns(filename)
        expect(res).to be true
    end
    it("should be able to determine whether the input csv is value or not") do

        filename = Rails.root.join('spec', 'data', "bulk_add_users_wrong_2.csv")
        users, valid = BulkAddUsersHelper.parseData(filename)
        expect(valid).to be false

        filename = Rails.root.join('spec', 'data', "bulk_add_users_wrong_3.csv")
        users, valid = BulkAddUsersHelper.parseData(filename)
        expect(valid).to be false

        filename = Rails.root.join('spec', 'data', "bulk_add_users_wrong_4.csv")
        users, valid = BulkAddUsersHelper.parseData(filename)
        expect(valid).to be false

        filename = Rails.root.join('spec', 'data', "bulk_add_users_correct.csv")
        users, valid = BulkAddUsersHelper.parseData(filename)
        expect(valid).to be true

    end
end
