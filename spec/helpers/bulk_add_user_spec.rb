require 'rails_helper'
require 'csv'

RSpec.describe BulkAddUsersHelper, :type => :helper do
    it("should determine whether the number of columns is correct") do
        filename = Rails.root.join('spec', 'data', "bulk_add_users_wrong.csv")
        csv = CSV.read(filename)
        res = BulkAddUsersHelper.checkNumColumns(csv)
        expect(res).to be false

        filename = Rails.root.join('spec', 'data', "bulk_add_users_correct.csv")
        csv = CSV.read(filename)
        res = BulkAddUsersHelper.checkNumColumns(csv)
        expect(res).to be true
    end
end
