require 'rails_helper'

RSpec.describe 'Bulk Add User Test', type: :system do
  describe "full run though" do 
    it "the user should upload csv, confirm it, and have the changes reflected in the database" do
      visit "/bulk_add_users"
      sleep 5
    end  
  end
  
end
