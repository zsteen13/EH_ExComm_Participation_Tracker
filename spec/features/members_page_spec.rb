# frozen_string_literal: true

require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature 'Members Page'  do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'visit members' do
    visit('/members')
    expect(page).to have_content 'Bulk Add Users'
  end

  scenario 'view a member' do
    visit('/members')
    find("a[href='/members/1']").click
    expect(page).to have_content 'General Info'
  end

  scenario 'sort members above' do
    visit('/members')
    fill_in 'search', with: '49'
    click_button 'Set Threshold Points Above'
    expect(page).to have_content '50'
  end

  scenario 'sort members below' do
    visit('/members')
    fill_in 'search', with: '49'
    click_button 'Set Threshold Points Below'
    expect(page).to have_content '0'
    expect(page).not_to have_content '50'
  end

  scenario 'edit a member' do
    visit('/members')
    find("a[href='/members/1/edit']").click
    expect(page).to have_content 'Edit Member'

    # internal committee should yield these subcommitee options
    expect(page).to have_select('user[subcommittee]', with_options: [
                                  'None',
                                  'Community Building',
                                  'Research and Technology',
                                  'Professional Development'
                                ])

    # changing to external should change subcommitee options
    select 'External', from: 'user[committee]'
    expect(page).to have_select('user[subcommittee]', with_options: %w[
                                  None
                                  Service
                                ])

    select 'Service', from: 'user[subcommittee]'

    click_button 'commit'
  end

  scenario 'edit a member, again, for controller' do
    visit('/members')
    find("a[href='/members/1/edit']").click

    # changing to external should change subcommitee options
    select 'Internal', from: 'user[committee]'

    click_button 'commit'

    visit('/members')
    find("a[href='/members/1/edit']").click

    # changing to external should change subcommitee options
    select 'None', from: 'user[committee]'

    click_button 'commit'
  end

  scenario 'edit a member error handling' do
    visit('/members')
    find("a[href='/members/1/edit']").click
    expect(page).to have_content 'Edit Member'

    # change to invalid email
    fill_in 'user[email]', with: 'invalid123email'
    click_button 'commit'

    expect(page).to have_content 'An Error occured. Please check your inputs and try again. email is invalid'
  end

  scenario 'create new member error handling' do
    visit('/members')
    find("a[href='members/new']").click
    expect(page).to have_content 'Create a Member'

    # change to invalid email
    click_button 'commit'

    expect(page).to have_content 'Create a Member'
  end

  scenario 'delete a member' do
    visit('/members')
    find("a[href='/members/1/delete']").click
    expect(page).to have_content 'Are you sure you want to permanently delete this member from the system?'
    click_button 'commit'
  end

  scenario 'edit site point threshold' do
    visit('/members')
    click_link 'point_threshold_btn'
    expect(page).to have_content 'Point Threshold Value:'
    fill_in 'point_threshold_value', with: '99'
    click_button 'commit'
    expect(page).to have_content 'Value Successfully Updated!'
  end
end
