# frozen_string_literal: true

require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature 'Profile Page' do
  include_context 'when authenticated as admin'

  scenario 'view user attendance' do
    visit '/profile'
    click_link 'Activities Attended'
    expect(page).to have_content 'Activities Attended'
  end
end
