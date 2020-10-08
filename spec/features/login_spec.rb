require 'rails_helper'

RSpec.describe 'log in to website', type: :feature do
    scenario 'log in prompt' do
        visit root_path
        expect(page).to have_content 'Please log in below...'
        fill_in 'first_name', with: 'Zachary'
        fill_in 'last_name', with: 'Steen'
        fill_in 'uin', with: '000000000'
        click_button 'Login'
        sleep 1
        expect(page).to have_content 'Select an option from the left menu bar.'
    end
end