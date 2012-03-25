require 'spec_helper'

describe "SigningIns" do
  describe "signing in via confirmation" do
    include EmailSpec::Helpers
    let(:user) {Factory(:user)}
    
    it "sign in upon email confirmation" do
      open_email(user.email, :with_subject => "Confirmation instructions") 
      click_first_link_in_email
      page.should have_content("Your account was successfully confirmed")
      page.should have_content("Signed in as #{user.email}")   
    end    
  end
end
