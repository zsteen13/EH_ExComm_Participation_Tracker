# frozen_string_literal: true

require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature 'Activities Page' do
  include_context 'when authenticated as member' # support context to log in a user

  scenario 'visit activities' do
    visit('/activities')
    expect(page).to have_content 'Meet and Greet'
  end
end

feature 'Create New Activity' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'Date/Time Error in Create New Activities' do
    visit('/activities')
    find("a[href='/activities/new']").click

    fill_in 'activity_name', with: 'Rspec Actvity'
    fill_in 'activity_type', with: 'Event'
    fill_in 'date_input', with: '203904034'
    fill_in 'time_input', with: '3:44PM'
    fill_in 'point_value', with: '1'
    fill_in 'description', with: 'testing'

    click_button 'Create'

    expect(page).to have_content 'The date or time input was not valid please check your input for date and time'
  end

  scenario 'Blank Space Error in Create New Activities' do
    visit('/activities')
    find("a[href='/activities/new']").click

    fill_in 'activity_name', with: '  '
    fill_in 'activity_type', with: 'Event'
    fill_in 'date_input', with: '11/12/2020'
    fill_in 'time_input', with: '3:44PM'
    fill_in 'point_value', with: '1'
    fill_in 'description', with: 'testing'

    click_button 'Create'

    expect(page).to have_content 'One or more input fields were left blank.'
  end

  scenario 'Blank Space Error in Create New Activities' do
    visit('/activities')
    find("a[href='/activities/new']").click

    fill_in 'activity_name', with: 'Rspec'
    fill_in 'activity_type', with: 'Event'
    fill_in 'date_input', with: '11/12/2020'
    fill_in 'time_input', with: '3:44PM'
    fill_in 'point_value', with: '1'
    fill_in 'description', with: '    '

    click_button 'Create'

    expect(page).to have_content 'One or more input fields were left blank.'
  end
end

feature 'View Attendance' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'checks attendance for Meet and Greet' do
    visit 'activities'
    expect(page).to have_current_path '/activities'
    find_link('View Attendance', href: '/activities/1').click
    expect(page).to have_content 'Meet and Greet Attendence'
    expect(page).to have_content 'First Name Last Name UIN Email'
    click_link 'Return to Activities'
    expect(page).to have_current_path '/activities/'
  end

  scenario 'checks attendance for General Meeting' do
    visit 'activities'
    expect(page).to have_current_path '/activities'
    find_link('View Attendance', href: '/activities/2').click
    expect(page).to have_current_path '/activities/2'
    expect(page).to have_content 'General Meeting Attendence'
    expect(page).to have_content 'First Name Last Name UIN Email'
    click_link 'Return to Activities'
    expect(page).to have_current_path '/activities/'
  end

  scenario 'Non-student member displays correctly' do
    visit 'activities'
    expect(page).to have_current_path '/activities'
    find_link('View Attendance', href: '/activities/1').click
    expect(page).to have_current_path '/activities/1'
    expect(page).to have_content 'Meet and Greet Attendence'
    expect(page).to have_content 'ProfX@tamu.edu'
    click_link 'Return to Activities'
    expect(page).to have_current_path '/activities/'
  end
end
