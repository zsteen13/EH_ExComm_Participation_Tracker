require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature ActivitiesController, type: :system do
  feature 'create activities admin' do
    include_context 'when authenticated as admin' # support context to log in a user

    scenario 'admin should be able to create activites' do
      visit 'activities'
      expect(page).to have_current_path '/activities'

      click_link 'Create Activity'

      expect(page).to have_current_path '/activities/new'
      expect(page).to have_content 'Create Activites'

      activity_name = 'New Member Social'
      activity_type = 'Social'
      date = '12/31/2020'
      time = '03:30PM'
      point_value = 3
      description = 'Social for new members'

      fill_in 'Activity Name', with: activity_name
      fill_in 'Activity Type', with: activity_type
      fill_in 'date', with: date
      fill_in 'time_input', with: time
      fill_in 'Point Value', with: point_value
      fill_in 'Description', with: description

      click_button 'Create'

      expect(page).to have_content activity_name
      expect(page).to have_content activity_type
      expect(page).to have_content point_value
      expect(page).to have_content description
    end
  end
end
