require 'spec_helper'

describe "CreatingUsers" do
  let(:admin_user) {Factory(:admin_user)}
  
  before do
    login_as(admin_user)
    visit('/')
    click_link("Admin")
    click_link("Users")
    click_link("New User")
  end
  
  it "creating a new user" do
    fill_in("Email", :with => "newbee@gmail.com")
    fill_in("Password", :with => "password")
    click_button("Create User")
    page.should have_content("User has been created.")
  end
  
  it "leaving email blank results in an error" do
    fill_in("Email", :with => "")
    fill_in("Password", :with => "password")
    click_button("Create User")
    page.should have_content("User has not been created.")
    page.should have_content("Email can't be blank")
  end
end
