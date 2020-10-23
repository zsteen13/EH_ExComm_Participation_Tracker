# frozen_string_literal: true

require 'rails_helper'
require 'pp' # pretty printer, outputs to console

describe ProfileController, type: :system do
  describe 'during first time signup' do
    user_id = UserKey.find_by(key: 'testkey').user_id
    first_password = '123'
    second_password = '123'
    it 'destroys UserKey when changing password' do
      patch '/profile/change_password', params: { user: { id: user_id, first_password: first_password, second_password: second_password } }
      expect(UserKey.where(key: 'testkey')).not_to exist
    end
  end
end
