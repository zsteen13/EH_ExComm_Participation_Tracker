require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature 'Activities Page'  do 
  include_context 'when authenticated as member' # support context to log in a user
  
  scenario 'visit activities' do
    visit('/activities')
    sleep 1
    expect(page).to have_content "Meet and Greet"
  end
end