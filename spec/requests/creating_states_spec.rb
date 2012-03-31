require 'spec_helper'

describe "CreatingStates" do
  let(:admin){Factory(:admin_user)}
  
  before do
    login_as(admin)
    visit('/')
  end
  
  it "create states" do
    click_link("Admin")
    click_link("States")
    click_link("New State")
    fill_in("Name", :with => "Duplicate")
    click_button("Create State")
    page.should have_content("State has been created.")
  end
end
