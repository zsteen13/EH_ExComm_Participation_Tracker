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

feature 'Add Committee Information' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'back button test no changes' do
    visit('committees')
    find("a[href='/committees/new']").click
    expect(page).to have_content 'Add Committee'

    fill_in 'committee_committee', with: 'No Change'
    fill_in 'committee_point_threshold', with: '212'

    find("a[id='return_to_committees']").click

    expect(page).to have_current_path '/committees'
    expect(page).not_to have_content 'No Change'
  end

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

  scenario 'back button test no changes' do
    visit('committees')
    find("a[href='/committees/2/edit']").click
    expect(page).to have_content 'Edit Committee Information'

    fill_in 'committee_head_first_name', with: 'No Change'
    fill_in 'committee_email', with: 'nochange@tamu.edu'

    find("a[id='return_to_committees']").click

    expect(page).to have_current_path '/committees'
    expect(page).not_to have_content 'No Change'
    expect(page).not_to have_content 'nochange@tamu.edu'
  end

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

feature 'View Subcommittee' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'view subcommittee for Internal' do
    visit('committees')
    find("a[href='/committees/0/subcommittees']").click
    expect(page).to have_content 'Internal Subcommittees'
    expect(page).to have_content 'Community Building'
    expect(page).to have_content 'Research and Technology'
    expect(page).to have_content 'Professional Development'
  end

  scenario 'view subcommittee for External' do
    visit('committees')
    find("a[href='/committees/1/subcommittees']").click
    expect(page).to have_content 'External Subcommittees'
    expect(page).to have_content 'Service'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end
end

feature 'View Members in a Committee' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'view members for Internal' do
    visit('committees')
    find("a[href='/committees/0']").click
    expect(page).to have_content 'Internal Members'
    expect(page).to have_content 'Non admin'
    expect(page).to have_content 'nonadmintest@gmail.com'
    expect(page).to have_content 'Trev'
    expect(page).to have_content 'yoyoyo@aol.com'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end

  scenario 'view members for Operations' do
    visit('committees')
    find("a[href='/committees/2']").click
    expect(page).to have_content 'Operations Members'
    expect(page).to have_content 'First'
    expect(page).to have_content 'test@gmail.com'

    expect(page).not_to have_content 'Internal Members'
    expect(page).not_to have_content 'Non admin'
    expect(page).not_to have_content 'nonadmintest@gmail.com'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end
end

feature 'Delete Committee' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'back button test no changes' do
    visit('committees')
    find("a[id='1_delete']").click
    expect(page).to have_content 'Delete Committee Information'

    find("a[id='return_to_committees']").click

    expect(page).to have_current_path '/committees'
    expect(page).to have_content 'External'

    visit('/members')
    expect(page).to have_content 'External'
  end

  scenario 'delete a committee' do
    visit('committees')
    find("a[id='2_delete']").click
    expect(page).to have_content 'Delete Committee Information'

    click_button 'Delete Committee'

    expect(page).to have_current_path '/committees'
    expect(page).not_to have_content 'Operations'

    visit('/members')
    expect(page).not_to have_content 'Operations'
  end
end
