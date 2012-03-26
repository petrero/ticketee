require 'spec_helper'

describe "EditingUsers" do
  let(:admin_user){Factory(:admin_user)}
  let(:user){Factory(:confirmed_user)}
  
  before do
    @users = Array.new()
    @users.push(admin_user)
    @users.push(user) 
    login_as(admin_user)
    visit('/')
    click_link("Admin")
    click_link("Users")
    click_link(user.email)
    click_link("Edit User")
  end
  
  it "updating a user's details" do
    fill_in("Email", :with => "newguy@ticketee.com")
    click_button("Update User")
    page.should have_content("User has been updated.")
    page.should have_content("newguy@ticketee.com")
    page.should have_no_content(user.email)
  end
  
  it "toggling user's admin ability" do
    page.check("Is an admin?")
    click_button("Update User")
    page.should have_content("#{user.email} (Admin)")
  end
  
  it "not updating a user with an invalid email fields" do
    fill_in("Email", :with => "fakefakefake")
    click_button("Update User")
    page.should have_content("User has not been updated.")
    page.should have_content("Email is invalid")  
  end
end
