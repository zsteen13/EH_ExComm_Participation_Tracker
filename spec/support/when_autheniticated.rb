# https://stackoverflow.com/questions/32479612/rspec-capybara-loginuser-not-working
def authenticate(first, last, uin)
  visit '/welcome'
  within(:id, 'login') do
    fill_in 'First name', :with => first
    fill_in 'Last name', :with => last
    fill_in 'uin', :with => uin
  end
  click_button 'Login'
end

RSpec.shared_context 'when authenticated as member' do
  background do
    authenticate 'Non Admin', 'Test', 11111111
  end
end


RSpec.shared_context 'when authenticated as admin' do
  background do
    authenticate 'Admin', 'Test', 22222222
  end

end
