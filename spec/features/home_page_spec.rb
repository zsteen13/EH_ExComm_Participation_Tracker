feature 'Home Page' do

  scenario 'visit not logged in' do
    visit "/"
    expect(page.current_path).to have_title "Welcome to the EH Excom Member Point Tracker"
  end
end
