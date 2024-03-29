# frozen_string_literal: true

# https://stackoverflow.com/questions/32479612/rspec-capybara-loginuser-not-working
def authenticate(uin_email, password)
  visit '/welcome'
  within(:id, 'login') do
    fill_in 'uin_email', with: uin_email
    fill_in 'password', with: password
  end
  click_button 'Login'
end

RSpec.shared_context 'when authenticated as member' do
  background do
    authenticate 111_111_111, 'Test'
  end
end

RSpec.shared_context 'when authenticated as admin' do
  background do
    authenticate 222_222_222, 'Test'
  end
end

RSpec.shared_context 'before when authenticated as member' do
  before do
    authenticate 111_111_111, 'Test'
  end
end

RSpec.shared_context 'before when authenticated as admin' do
  before do
    authenticate 222_222_222, 'Test'
  end
end

RSpec.shared_context 'when authenticated as member using email' do
  before do
    authenticate 'nonadmintest@gmail.com', 'Test'
  end
end
