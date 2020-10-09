require 'rails_helper'
require 'pp' # pretty printer, outputs to console

describe MembersController, type: :system do
  feature 'access members page' do
    include_context 'when authenticated as admin' # support context to log in a user

    scenario 'admin should be able to view members' do
      visit 'members'
      expect(page).to have_current_path '/members'
    end

    scenario 'admin should be able to create a member' do
      visit 'members'
      click_link 'Create New Member'

      fill_in 'user_first_name', :with => 'test first'
      fill_in 'user_last_name', :with => 'test last'
      fill_in 'user_uin', :with => '012123123'
      fill_in 'user_email', :with => 'email@test.com'
      fill_in 'user_committee', :with => 'internal'
      fill_in 'user_subcommittee', :with => 'sub'
      fill_in 'user_total_points', :with => 2

      click_button 'commit'
    end
  end
end
