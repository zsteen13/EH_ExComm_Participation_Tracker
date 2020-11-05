# frozen_string_literal: true

require 'rails_helper'
require 'pp' # pretty printer, outputs to console

describe MembersController, type: :system do
  feature 'access members page' do
    include_context 'when authenticated as admin' # support context to log in a user

    scenario 'admin should be able to view members' do
      visit '/members'
      expect(page).to have_current_path '/members'
    end

    
  end
end
