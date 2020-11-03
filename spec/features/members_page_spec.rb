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
    find("a[href='/members/2']").click
    expect(page).to have_content 'General Info'
  end

  scenario 'edit a member' do
    visit('/members')
    find("a[href='/members/2/edit']").click
    expect(page).to have_content 'Edit Member'
  end

  scenario 'delete a member' do
    visit('/members')
    find("a[href='/members/2/delete']").click
    expect(page).to have_content 'Are you sure you want to permanently delete this member from the system?'
    click_button 'commit'
  end
end
