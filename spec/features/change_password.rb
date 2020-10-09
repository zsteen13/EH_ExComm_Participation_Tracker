require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature 'change password'  do 
  feature 'while logged in'  do 
    include_context 'when authenticated as member'
    scenario 'passwords match' do
      visit '/profile/change_password'
      fill_in 'user_first_password', :with => '123'
      fill_in 'user_second_password', :with => '123'
      click_on 'Update User'
      expect(page).to have_current_path '/welcome'
    end
    scenario 'passwords dont match' do
      visit '/profile/change_password'
      fill_in 'user_first_password', :with => '321'
      fill_in 'user_second_password', :with => '123'
      click_on 'Update User'
      expect(page).to have_current_path '/profile/change_password'
    end
  end
  feature 'while not logged in'
    scenario 'passwords match' do
      visit '/profile/change_password?key=testkey'
      fill_in 'user_first_password', :with => '123'
      fill_in 'user_second_password', :with => '123'
      click_on 'Update User'
      expect(page).to have_current_path '/welcome'
    end
    scenario 'passwords dont match' do
      visit '/profile/change_password?key=testkey'
      fill_in 'user_first_password', :with => '321'
      fill_in 'user_second_password', :with => '123'
      click_on 'Update User'
      expect(page).to have_current_path '/profile/change_password'
    end
  end
end
