require 'rails_helper'

describe MembersController do

  describe 'logout' do
    
    # --- BUILD UP ---
    
    # This before :all method is called once before the tests in this describe
    before :all do
    end
    
    # This before :each method is called before each test in this describe
    before :each do
    end
    # --- TEAR DOWN ---
    
    # This after :each method is called after the end of each test in this describe
    after :each do
    end
    
    # This after :all method is called after the last test in this describe
    after :all do
    end
    
    # --- SPECS ---
    
    it "Greets the user" do

    end
  end


  describe 'Logged in as non admin' do
    before :all do 
      # login as non admin
    end
  end

  describe 'Not logged in' do
    it 'Sends the user to the login screen' do
      visit '/members'

    end
  end
end
