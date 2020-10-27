# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/member_mailer
class MemberMailerPreview < ActionMailer::Preview
  def signup_email
    MemberMailer.with(user: User.first).signup_email
  end
end
