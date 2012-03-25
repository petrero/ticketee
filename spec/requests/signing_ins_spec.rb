require 'spec_helper'

describe "SigningIns" do
  describe "signing in via confirmation email" do
    include EmailSpec::Helpers
    let(:user) {Factory(:user)}
    
    it "sign in upon email confirmation" do
      open_email(user.email, :with_subject => "Confirmation instructions") 
      click_first_link_in_email
      page.should have_content("Your account was successfully confirmed")
      page.should have_content("Signed in as #{user.email}")   
    end    
  end
  
  describe "signing in Devise form" do
    let(:user) {Factory(:confirmed_user)}
    
    it "sign in via form" do
      visit('/')
      click_link("Sign in")
      fill_in("Email", :with => user.email)
      fill_in("Password", :with => user.password)
      click_button("Sign in")
      page.should have_content("Signed in successfully.")
    end
  end
end
