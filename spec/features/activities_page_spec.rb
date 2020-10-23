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

feature 'View Attendance' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'checks attendance for Meet and Greet' do
    visit 'activities'
    expect(page).to have_current_path '/activities'
    find_link('View Attendance', href: '/activities/1').click
    expect(page).to have_content 'Meet and Greet Attendence'
    expect(page).to have_content 'First Name Last Name UIN'
    click_link 'Return to Activities'
    expect(page).to have_current_path '/activities/'
  end

  scenario 'checks attendance for Meet and Greet' do
    visit 'activities'
    expect(page).to have_current_path '/activities'
    find_link('View Attendance', href: '/activities/2').click
    expect(page).to have_content 'General Meeting Attendence'
    expect(page).to have_content 'First Name Last Name UIN'
    click_link 'Return to Activities'
    expect(page).to have_current_path '/activities/'
  end
end
