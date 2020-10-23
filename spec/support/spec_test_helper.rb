# https://stackoverflow.com/questions/10121835/how-do-i-simulate-a-login-with-rspec
module SpecTestHelper
  def self.login_admin
    user = User.find_by(uin: 222_222_222) # this is vulnerable to int uin becoming string uin.
    session[:user_id] = user
  end

  def self.login_member
    user = User.find_by(uin: 111_111_111)
    session[:user_id] = user
  end

  def self.logout
    session[:user_id] = nil
  end

  def self.current_user
    User.find(session[:user])
  end
end
