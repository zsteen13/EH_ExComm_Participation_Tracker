require 'rails_helper'
require 'pp' # pretty printer, outputs to console

feature 'Home Page'  do 
  include_context 'when authenticated as member' # support context to log in a user
  
  scenario 'visit logged in' do
    expect(page).to have_current_path '/welcome'
    expect(page).to have_content "Let's Speak Some Latin"
  end
end
