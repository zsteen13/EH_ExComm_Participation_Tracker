require 'rails_helper'

RSpec.describe MemberMailer, type: :mailer do
  feature 'Emailer' do
    background do
      clear_emails
      MemberMailer.with(user: User.find(UserKey.first!.user_id)).signup_email.deliver_now
      open_email('nonadmintest@gmail.com')
    end

    scenario 'testing for email content' do
      expect(current_email).to have_content "Howdy #{User.find(1).first_name}!"
    end

    scenario 'following link' do
      current_email.click_link 'this link'
      expect(page).to have_current_path(profile_change_password_path(key: UserKey.first!.key))
      expect(page).to have_content 'Please enter a password'
    end
  end
end
