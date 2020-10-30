# frozen_string_literal: true

require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature BulkAddUsersController do
  feature 'Bulk Add Users with auth' do
    include_context 'when authenticated as admin' # support context to log in a user

    scenario 'admin uploads a correct csv' do
      visit '/members'
      expect(page).to have_current_path '/members'
      expect(page).to have_content 'Bulk Add Users'
      click_on('Bulk Add Users')
      expect(page).to have_current_path '/bulk_add_users'
      expect(page).to have_content 'Attach CSV file with new users.'

      filepath = Rails.root.join 'spec', 'data', 'bulk_add_users_correct.csv'
      attach_file('new_users', filepath, make_visible: true)

      click_button 'upload_btn'
      expect(page).to have_content 'Is this correct'

      click_link 'confirm_btn'
      expect(page).to have_current_path '/members'

      expect(page).to have_content 'Internal'
      expect(page).to have_content 'External'

      open_email('moore.trev@tamu.edu')
      expect(current_email).to have_content 'Howdy'
    end

    scenario 'admin uploads a incorrect csv' do
      visit '/members'
      expect(page).to have_current_path '/members'
      expect(page).to have_content 'Bulk Add Users'

      click_link 'bulk_add_users_btn'
      expect(page).to have_current_path '/bulk_add_users'
      expect(page).to have_content 'Attach CSV file with new users.'

      filepath = Rails.root.join 'spec', 'data', 'bulk_add_users_wrong_2.csv'

      attach_file('new_users', filepath, make_visible: true)

      click_button 'upload_btn'
      expect(page).to have_content 'Parsing Error'
      expect(page).to have_content 'the field email is invalid'
    end
    scenario 'help page exists' do
      visit '/bulk_add_users/help'
      expect(page).to have_current_path '/bulk_add_users/help'
      expect(page).to have_content 'Purpose'
    end
    scenario 'help page buttons work' do
      visit '/bulk_add_users/help'
      click_link 'correct_csv_all_fields-btn'
      click_link 'correct_csv_required_fields-btn'
      click_link 'correct_csv_some_optional_fields-btn'
      click_link 'incorrect_csv_email_last_name_switched-btn'
      click_link 'incorrect_csv_not_enough_columns-btn'
      sleep 1

      full_path = "#{DOWNLOAD_PATH}/correct_csv_all_fields.csv"
      expect(File.exist?(full_path)).to be true
      File.delete(full_path) if File.exist?(full_path)

      full_path = "#{DOWNLOAD_PATH}/correct_csv_required_fields.csv"
      expect(File.exist?(full_path)).to be true
      File.delete(full_path) if File.exist?(full_path)

      full_path = "#{DOWNLOAD_PATH}/correct_csv_some_optional_fields.csv"
      expect(File.exist?(full_path)).to be true
      File.delete(full_path) if File.exist?(full_path)

      full_path = "#{DOWNLOAD_PATH}/incorrect_csv_email_last_name_switched.csv"
      expect(File.exist?(full_path)).to be true
      File.delete(full_path) if File.exist?(full_path)

      full_path = "#{DOWNLOAD_PATH}/incorrect_csv_not_enough_columns.csv"
      expect(File.exist?(full_path)).to be true
      File.delete(full_path) if File.exist?(full_path)
    end
  end

  feature 'Bulk Add User without auth' do
    include_context 'when authenticated as member' # support context to log in a user

    scenario 'the user should not see the bulk add users button' do
      visit '/members'
      expect(page).not_to have_current_path '/members'
      expect(page).not_to have_content 'Bulk Add Users'
    end

    scenario 'the user should show not be able to access any of the bulk add user pages' do
      path = '/bulk_add_users'
      visit path
      expect(page).not_to have_current_path path

      path = '/bulk_add_users/show'
      visit path
      expect(page).not_to have_current_path path
    end
  end
end
