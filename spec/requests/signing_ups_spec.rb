require 'spec_helper'

describe "SigningUps" do
  it "sign up" do
    visit('/')
    click_link("Sign up")
    fill_in("Email", :with => "user@ticketee.com")
    fill_in("Password", :with => "password")
    fill_in("Password confirmation", :with => "password")
    click_button("Sign up")
    page.should have_content("A message with a confirmation link has been sent to your email address. Please open the link to activate your account.")
  end
end
