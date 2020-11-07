# frozen_string_literal: true

require 'rails_helper'

data_path = Rails.root.join 'spec', 'data', 'bulk_add_attendance'

feature 'Bulk Add Attendance' do
  feature 'on event with attendance' do
    include_context 'when authenticated as admin'

    before(:each) do
      visit activities_path
      find("a[href='/activities/1']").click
      expect(page).to have_no_content '123456789'
      expect(page).to have_no_content '777777777'
      expect(page).to have_no_content '000000001'
      expect(page).to have_no_content '000000000'
      click_on 'Bulk Add Attendees'
      expect(page).to have_current_path '/activities/1/bulk_add'
    end

    scenario 'click back button' do
      click_on 'Back to Attendance'
      expect(page).to have_current_path '/activities/1'
    end

    scenario 'add 6 users' do
      csv_file = data_path.join 'bulk_add_attendance_correct_6_users.csv'
      attach_file 'new_users', csv_file, make_visible: true
      expect(page).to have_content 'bulk_add_attendance_correct_6_users.csv'
      find(id: 'upload_btn').click
      sleep 1
      expect(body).to have_selector 'p', text: 'Note: These UINs were rejected because the member is already listed as an attendee.'
      # already attended
      expect(body).to have_selector 'p', text: '111111111'
      expect(body).to have_selector 'p', text: '222222222'
      # To be added
      expect(body).to have_selector 'td', text: '000000000'
      expect(body).to have_selector 'td', text: '000000001'
      expect(body).to have_selector 'td', text: '123456789'
      expect(body).to have_selector 'td', text: '777777777'

      click_on 'Confirm'

      expect(page).to have_current_path '/activities/1'
      expect(body).to have_content '000000000'
      expect(body).to have_content '000000001'
      expect(page).to have_content '123456789'
      expect(page).to have_content '777777777'
    end
    scenario 'add 1 user' do
      csv_file = data_path.join 'bulk_add_attendance_correct_1_user.csv'
      attach_file 'new_users', csv_file, make_visible: true
      expect(page).to have_content 'bulk_add_attendance_correct_1_user.csv'
      find(id: 'upload_btn').click
      sleep 0.2 # Seems to need a second
      expect(body).to have_selector 'p', text: 'Note: These UINs were rejected because the member is already listed as an attendee.'
      # already attended
      expect(body).to have_selector 'p', text: '111111111'

      click_on 'Confirm'

      expect(page).to have_current_path '/activities/1'
      expect(body).to have_content '111111111'
      expect(body).to have_content '222222222'
      expect(body).to have_no_content '000000000'
      expect(body).to have_no_content '000000001'
      expect(page).to have_no_content '123456789'
      expect(page).to have_no_content '777777777'
    end

    scenario 'add 6 UINs, one is nonexistant' do
      csv_file = data_path.join 'bulk_add_attendance_incorrect_valid_but_nonexistant_uin.csv'
      attach_file 'new_users', csv_file, make_visible: true
      expect(page).to have_content 'bulk_add_attendance_incorrect_valid_but_nonexistant_uin.csv'
      find(id: 'upload_btn').click
      sleep 0.2
      expect(body).to have_selector 'p', text: 'Note: These UINs were rejected because the member is already listed as an attendee.'
      expect(body).to have_selector 'p', text: 'Note: These UINs were rejected because they do not belong to any existing members.'
      # already attended
      expect(body).to have_selector 'p', text: '111111111'
      expect(body).to have_selector 'p', text: '222222222'
      # nonexistant
      expect(body).to have_selector 'p', text: '876687680'

      # To be added
      expect(body).to have_selector 'td', text: '000000001'
      expect(body).to have_selector 'td', text: '123456789'
      expect(body).to have_selector 'td', text: '777777777'

      click_on 'Confirm'

      expect(page).to have_current_path '/activities/1'
      expect(page).to have_content '000000001'
      expect(page).to have_content '123456789'
      expect(page).to have_content '777777777'
    end
    scenario 'add 6 UINs, one is malformed' do
      csv_file = data_path.join 'bulk_add_attendance_incorrect_valid_but_nonexistant_uin.csv'
      attach_file 'new_users', csv_file, make_visible: true
      expect(page).to have_content 'bulk_add_attendance_incorrect_valid_but_nonexistant_uin.csv'
      find(id: 'upload_btn').click
      sleep 0.2
      expect(body).to have_selector 'p', text: 'Note: These UINs were rejected because the member is already listed as an attendee.'
      expect(body).to have_selector 'p', text: 'Note: These UINs were rejected because they do not belong to any existing members.'
      # already attended
      expect(body).to have_selector 'p', text: '111111111'
      expect(body).to have_selector 'p', text: '222222222'
      # nonexistant
      expect(body).to have_selector 'p', text: '876687680'
      # To be added
      expect(body).to have_selector 'td', text: '000000001'
      expect(body).to have_selector 'td', text: '123456789'
      expect(body).to have_selector 'td', text: '777777777'

      click_on 'Confirm'
      sleep 0.2
      expect(page).to have_current_path '/activities/1'
      expect(page).to have_no_content '000000000'
      expect(page).to have_no_content '876687680'
      expect(page).to have_content '000000001'
      expect(page).to have_content '111111111'
      expect(page).to have_content '222222222'
      expect(page).to have_content '123456789'
      expect(page).to have_content '777777777'
    end
    scenario 'use csv with no header' do
      csv_file = data_path.join 'bulk_add_attendance_incorrect_no_header.csv'
      attach_file 'new_users', csv_file, make_visible: true
      expect(page).to have_content 'bulk_add_attendance_incorrect_no_header.csv'
      find(id: 'upload_btn').click
      sleep 0.2
      expect(page).to have_content 'Parsing Error'
      expect(page).to have_selector 'p', text: "The provided csv does not have a proper header of 'UIN'."
    end
  end
end
