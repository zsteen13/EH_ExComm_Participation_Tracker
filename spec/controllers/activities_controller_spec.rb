# frozen_string_literal: true

require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature ActivitiesController, type: :system do
  feature 'create activities admin' do
    include_context 'when authenticated as admin' # support context to log in a user

    scenario 'admin should be able to create activites' do
      visit 'activities'
      expect(page).to have_current_path '/activities'

      click_link 'Create Activity'

      expect(page).to have_current_path '/activities/new'
      expect(page).to have_content 'Create Activities'

      activity_name = 'New Member Social'
      date = '12/31/2020'
      time = '03:30PM'
      point_value = 3
      description = 'Social for new members'

      fill_in 'Activity Name', with: activity_name
      page.select 'Misc', from: 'activity_type'
      fill_in 'date', with: date
      fill_in 'time_input', with: time
      fill_in 'Point Value', with: point_value
      fill_in 'Description', with: description
      click_button 'Create'

      expect(page).to have_content activity_name
      expect(page).to have_content point_value
      expect(page).to have_content description
      sleep 0.3
    end

    scenario 'admin should be able to add/delete attendee' do
      visit 'activities'
      expect(page).to have_current_path '/activities'
      expect(page).to have_content 'Meet and Greet'

      find_link('View Attendance', href: '/activities/1').click
      expect(page).to have_current_path '/activities/1'
      expect(page).not_to have_content '000000000'

      fill_in 'uin', with: '000000000'
      click_button 'commit'
      expect(page).to have_current_path '/activities/1'
      expect(page).to have_content '000000000'

      find_link('Delete', href: '/activities/1/delete/000000000').click
      expect(page).to have_current_path '/activities/1'
      expect(page).not_to have_content '000000000'
    end

    scenario 'admin should be able to delete activity' do
      visit 'activities'
      expect(page).to have_current_path '/activities'
      expect(page).to have_content 'Meet and Greet'

      find_link('Delete', href: '/activities/1/confirm_delete').click
      expect(page).to have_current_path '/activities/1/confirm_delete'

      find_link('Delete', href: '/activities/1/delete').click
      expect(page).to have_current_path '/activities'
      expect(page).not_to have_content 'Meet and Greet'
    end
  end
end
