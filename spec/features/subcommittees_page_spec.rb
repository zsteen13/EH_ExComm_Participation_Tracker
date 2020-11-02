# frozen_string_literal: true

require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature 'View SubCommmittees for Intenal' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'visit Subcommittee page for Internal' do
    visit('/committees/0/subcommittees')
    expect(page).to have_content 'Internal Subcommittees'
  end
end

feature 'Add New Subcommittee' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'back button test no changes' do
    visit('/committees/1/subcommittees')
    find("a[href='/committees/1/subcommittees/new']").click
    expect(page).to have_content 'Add Subcommittee to External'

    fill_in 'subcommittee_subcommittee', with: 'Do not change'

    find("a[href='/committees/1/subcommittees']").click

    expect(page).to have_current_path '/committees/1/subcommittees'
    expect(page).to have_content 'External Subcommittees'
    expect(page).not_to have_content 'Do not change'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end

  scenario 'add a subcommittee to Internal' do
    visit('/committees/0/subcommittees')
    find("a[href='/committees/0/subcommittees/new']").click
    expect(page).to have_content 'Add Subcommittee to Internal'

    fill_in 'subcommittee_subcommittee', with: 'Rspec Subcommittee'
    fill_in 'subcommittee_point_threshold', with: '100'

    click_button 'Add Subcommittee'

    expect(page).to have_current_path '/committees/0/subcommittees'
    expect(page).to have_content 'Rspec Subcommittee'
    expect(page).to have_content 'Research and Technology'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end

  scenario 'add a subcommittee to Operations' do
    visit('/committees/2/subcommittees')
    find("a[href='/committees/2/subcommittees/new']").click
    expect(page).to have_content 'Add Subcommittee to Operations'

    fill_in 'subcommittee_subcommittee', with: 'First Subcommittee'
    fill_in 'subcommittee_point_threshold', with: '90'

    click_button 'Add Subcommittee'

    expect(page).to have_current_path '/committees/2/subcommittees'
    expect(page).to have_content 'First Subcommittee'
    expect(page).to have_content '90'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end
end

feature 'Edit Subommittee Information' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'back button test no changes' do
    visit('/committees/1/subcommittees')
    find("a[href='/subcommittees/2/edit']").click
    expect(page).to have_content 'Edit Subcommittee'

    find("a[href='/committees/1/subcommittees']").click

    expect(page).to have_current_path '/committees/1/subcommittees'
    expect(page).to have_content 'External Subcommittees'
    expect(page).to have_content 'Professional Development'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end

  scenario 'edit subcommittee for Community Building' do
    visit('/committees/0/subcommittees')
    find("a[href='/subcommittees/0/edit']").click
    expect(page).to have_content 'Edit Subcommittee'

    fill_in 'subcommittee_subcommittee', with: 'Change Subcommittee'
    fill_in 'subcommittee_point_threshold', with: '23'

    click_button 'Edit Subcommittee'

    expect(page).to have_current_path '/committees/0/subcommittees'
    expect(page).to have_content 'Change Subcommittee'
    expect(page).to have_content 'Research and Technology'
    expect(page).to have_content '23'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end

  scenario 'edit subcommittee for Service' do
    visit('/committees/1/subcommittees')
    find("a[href='/subcommittees/3/edit']").click
    expect(page).to have_content 'Edit Subcommittee'

    fill_in 'subcommittee_subcommittee', with: 'Changing Service'
    fill_in 'subcommittee_point_threshold', with: '290'

    click_button 'Edit Subcommittee'

    expect(page).to have_current_path '/committees/1/subcommittees'
    expect(page).to have_content 'Changing Service'
    expect(page).to have_content 'Professional Development'
    expect(page).to have_content '290'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end
end

feature 'View Members in a Subcommittee' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'view members for Community Building' do
    visit('/committees/0/subcommittees')
    find("a[href='/subcommittees/0']").click
    expect(page).to have_content 'Community Building Members'
    expect(page).to have_content 'Admin'
    expect(page).to have_content 'admintest@gmail.com'
    expect(page).not_to have_content 'nonadmintest@gmail.com'

    find("a[href='/committees/0/subcommittees']").click
    expect(page).to have_content 'Internal Subcommittees'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end

  scenario 'view members for Community Building' do
    visit('/committees/0/subcommittees')
    find("a[href='/subcommittees/1']").click
    expect(page).to have_content 'Research and Technology Members'
    expect(page).to have_content 'David'
    expect(page).to have_content 'yoyoyo@aol.com'
    expect(page).not_to have_content 'admintest@gmail.com'
    expect(page).not_to have_content 'nonadmintest@gmail.com'

    find("a[href='/committees/0/subcommittees']").click
    expect(page).to have_content 'Internal Subcommittees'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end
end

feature 'Delete Subcommittee' do
  include_context 'when authenticated as admin' # support context to log in a user

  scenario 'back button test no changes' do
    visit('/committees/0/subcommittees')
    find("a[href='/subcommittees/1/delete']").click
    expect(page).to have_content 'Delete Subcommittee from Internal'

    find("a[href='/committees/0/subcommittees']").click

    expect(page).to have_current_path '/committees/0/subcommittees'
    expect(page).to have_content 'Internal Subcommittees'
    expect(page).to have_content 'Research and Technology'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end

  scenario 'delete a subcommittee from External' do
    visit('/committees/1/subcommittees')
    find("a[href='/subcommittees/2/delete']").click
    expect(page).to have_content 'Delete Subcommittee from External'

    click_button 'Delete Subcommittee'

    expect(page).to have_current_path '/committees/1/subcommittees'
    expect(page).not_to have_content 'Professional Development'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end

  scenario 'delete a subcommittee from External' do
    visit('/committees/0/subcommittees')
    find("a[href='/subcommittees/1/delete']").click
    expect(page).to have_content 'Delete Subcommittee from Internal'

    click_button 'Delete Subcommittee'

    expect(page).to have_current_path '/committees/0/subcommittees'
    expect(page).not_to have_content 'Research and Technology'

    find("a[id='return_to_committees']").click
    expect(page).to have_current_path '/committees'
  end
end
