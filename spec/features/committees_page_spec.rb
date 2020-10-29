# frozen_string_literal: true

require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature 'View Committees' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'visit committee page' do
    visit('committees')
    expect(page).to have_content 'Committees'
    expect(page).to have_content 'Name Committee Head Committee Contact Point Threshold Actions'
  end
end

feature 'View Subcommittee' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'view subcommittee for Internal' do
    visit('committees')
    find("a[href='/committees/0']").click
    expect(page).to have_content 'Internal Subcommittees'
    expect(page).to have_content 'Community Building'
    expect(page).to have_content 'Research and Technology'
  end

  scenario 'view subcommittee for External' do
    visit('committees')
    find("a[href='/committees/1']").click
    expect(page).to have_content 'External Subcommittees'
    expect(page).to have_content 'Service'
  end
end

feature 'Add Committee Information' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'add a committee' do
    visit('committees')
    find("a[href='/committees/new']").click
    expect(page).to have_content 'Add Committee'

    fill_in 'committee_committee', with: 'Rspec Committee'
    fill_in 'committee_point_threshold', with: '100'
    fill_in 'committee_head_first_name', with: 'Rspec Testing First Name'
    fill_in 'committee_head_last_name', with: 'Rspec Testing Last Name'
    fill_in 'committee_email', with: 'rspec@tamu.edu'

    click_button 'Add Committee'

    expect(page).to have_current_path '/committees'
    expect(page).to have_content 'Rspec Committee'
    expect(page).to have_content 'rspec@tamu.edu'
  end
end

feature 'Edit Committee Information' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'edit a committee' do
    visit('committees')
    find("a[href='/committees/0/edit']").click
    expect(page).to have_content 'Edit Committee Information'

    fill_in 'committee_head_first_name', with: 'Rspec Testing First Name'
    fill_in 'committee_email', with: 'rspec@tamu.edu'

    click_button 'Edit Information'

    expect(page).to have_current_path '/committees'
    expect(page).to have_content 'Rspec Testing First Name'
    expect(page).to have_content 'rspec@tamu.edu'
  end
end

feature 'Delete Committee Information' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'delete a committee' do
    visit('committees')
    find("a[id='0_delete']").click
    expect(page).to have_content 'Delete Committee Information'

    click_button 'Delete Committee'

    expect(page).to have_current_path '/committees'
    expect(page).not_to have_current_path 'Operations'
  end
end
