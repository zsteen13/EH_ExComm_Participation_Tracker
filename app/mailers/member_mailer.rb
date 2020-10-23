require 'pp'
class MemberMailer < ApplicationMailer
  default from: 'EHExComMemberPointTracker@gmail.com'

  def signup_email
    @user = params[:user]
    # get the UserKey entry that corresponds to this user, and return the special key
    # The special key allows for a unique user login url
    key = UserKey.find_by(user_id: @user.id).key
    @url = signup_url(key: key)
    # email in the form [ "Full Name" <email> ], shows the user their name in their email
    email_with_name = %("#{@user.first_name} #{@user.last_name}" <#{@user.email}>)
    mail(to: email_with_name, subject: 'Engineering Honors Executive Committee Point Tracker')
  end
end
