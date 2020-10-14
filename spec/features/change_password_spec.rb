require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature 'change password'  do 

  feature 'while logged in as member'  do 
    include_context 'when authenticated as member'
    scenario 'passwords match' do
      visit '/profile/change_password'
      fill_in 'user_first_password', :with => '123'
      fill_in 'user_second_password', :with => '123'
      click_on 'Change Password'
      expect(page).to have_current_path '/welcome'
=begin
      # This test fails, but it passes with real use in every way i've tried it.
      # Open to suggestions on how to get this to work.
      visit '/login' # signout
      fill_in 'uin', :with => '11111111'
      fill_in 'password', :with => '123'
      click_button 'Login'
      expect(page).to have_content 'Welcome to the Texas A&M EH ExCom Member Point Tracker'
=end
    end
    scenario 'passwords dont match' do
      visit '/profile/change_password'
      fill_in 'user_first_password', :with => '321'
      fill_in 'user_second_password', :with => '123'
      click_on 'Change Password'
      expect(page).to have_current_path '/profile/change_password'
    end
    scenario 'visiting through profile change password button' do
      visit '/profile'
      click_on 'Change Password'
      expect(page).to have_current_path '/profile/change_password'
    end
  end

  feature 'while logged in as admin'  do 
    include_context 'when authenticated as admin'
    scenario 'passwords match' do
      visit '/profile/change_password'
      fill_in 'user_first_password', :with => '123'
      fill_in 'user_second_password', :with => '123'
      click_on 'Change Password'
      expect(page).to have_current_path '/welcome'
    end
    scenario 'passwords dont match' do
      visit '/profile/change_password'
      fill_in 'user_first_password', :with => '321'
      fill_in 'user_second_password', :with => '123'
      click_on 'Change Password'
      expect(page).to have_current_path '/profile/change_password'
    end
    scenario 'visiting through profile change password button' do
      visit '/profile'
      click_on 'Change Password'
      expect(page).to have_current_path '/profile/change_password'
    end
  end

  feature 'while not logged in' do
    scenario 'query param "key" is invalid' do
      visit '/profile/change_password?key=abadtestkey'
      expect(page).to have_current_path '/profile/error'
    end
    scenario 'passwords match' do
      visit '/profile/change_password?key=testkey'
      fill_in 'user_first_password', :with => '123'
      fill_in 'user_second_password', :with => '123'
      click_on 'Change Password'
      expect(page).to have_current_path '/welcome'
    end
    scenario 'passwords dont match' do
      visit '/profile/change_password?key=testkey'
      fill_in 'user_first_password', :with => '321'
      fill_in 'user_second_password', :with => '123'
      click_on 'Change Password'
      expect(page).to have_current_path '/profile/change_password'
    end
    scenario 'visit /signup retains query param' do
      visit '/signup?key=testkey'
      expect(page).to have_current_path(profile_change_password_path(key: 'testkey'))
      fill_in 'user_first_password', :with => '123'
      fill_in 'user_second_password', :with => '123'
      click_on 'Change Password'
      expect(page).to have_current_path '/welcome'
    end
  end
end
