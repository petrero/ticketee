require 'spec_helper'

describe "DeletingUsers" do
  let(:user){Factory(:confirmed_user)}
  let(:admin_user){Factory(:admin_user)}
  
  before do
    @users = Array.new()
    @users.push(user)
    @users.push(admin_user)
    login_as(admin_user)
    visit('/')
    click_link("Admin")
    click_link("Users")
  end
  
  it "delete user" do
    click_link(user.email)
    click_link("Delete User")
    page.should have_content("User has been deleted")
    page.should have_no_content(user.email)
  end
  
  it "can not delete themselves" do
    click_link(admin_user.email)   
    click_link("Delete User")
    page.should have_content("You cannot delete yourself!")
  end
end
