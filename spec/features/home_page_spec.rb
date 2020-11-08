# frozen_string_literal: true

require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature 'Log in correctly' do
  feature 'with email' do
    include_context 'when authenticated as member using email' # support context to log in a user
    scenario 'shows profile page' do
      expect(page).to have_current_path root_path
      expect(page).to have_content 'My Profile'
    end
  end

  feature 'with uin' do
    include_context 'when authenticated as member' # support context to log in a user
    scenario 'shows profile page' do
      expect(page).to have_current_path root_path
      expect(page).to have_content 'My Profile'
    end
  end
end

feature 'Log in incorrectly' do
  scenario 'shows log in screen' do
    visit welcome_path
    expect(page).to have_current_path welcome_path

    fill_in 'uin_email', with: '11111111'
    fill_in 'password', with: 'A bad password'
    click_button 'Login'
    expect(page).to have_content 'Please log in below...'

    visit welcome_path
    fill_in 'uin_email', with: '11112222' # bad uin
    fill_in 'password', with: 'Test' # good password
    click_button 'Login'
    expect(page).to have_content 'Please log in below...'
  end
end
