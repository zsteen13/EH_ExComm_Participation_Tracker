require 'rails_helper'

RSpec.describe SessionsController do
  describe '#create' do
    subject { post :create, params: { uin: 22_222_222, last_name: 'Test' } }
    it 'redirects to /welcome' do
      expect(subject).to redirect_to('/welcome')
      expect(session[:user_id]) == User.find_by(uin: 22_222_222).id
    end

    subject { post :create, params: { uin: 22_222_220, last_name: 'Test_fail' } }
    it 'redirects to /welcome without logged in user' do
      expect(subject).to redirect_to('/welcome')
      expect(session[:user_id]).nil?
    end
  end
  describe '#new' do
    subject { post :new }
    it 'redirects to /welcome' do
      expect(subject).to redirect_to('/welcome')
      expect(session[:user_id]).nil?
    end
  end
end
