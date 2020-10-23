# https://stackoverflow.com/questions/32479612/rspec-capybara-loginuser-not-working
def authenticate(uin, password)
  visit '/welcome'
  within(:id, 'login') do
    fill_in 'uin', with: uin
    fill_in 'password', with: password
  end
  click_button 'Login'
end

RSpec.shared_context 'when authenticated as member' do
  background do
    authenticate 11_111_111, 'Test'
  end
end

RSpec.shared_context 'when authenticated as admin' do
  background do
    authenticate 22_222_222, 'Test'
  end
end

RSpec.shared_context 'before when authenticated as member' do
  before do
    authenticate 11_111_111, 'Test'
  end
end

RSpec.shared_context 'before when authenticated as admin' do
  before do
    authenticate 22_222_222, 'Test'
  end
end
