require 'spec_helper'

describe "Seeds" do
  let(:admin_user){Factory(:admin_user)}
  it "fill the development database" do
    load Rails.root + "db/seeds.rb"
    login_as(admin_user)
    visit('/')
    page.should have_content("Ticketee Beta")
    click_link("Ticketee Beta")
    click_link("New Ticket")
    fill_in("Title", :with => "Comments with state")
    fill_in("Description", :with => "Comments always have a state.")
    click_button("Create Ticket")
    find("#comment_state_id").should have_content("New")
    find("#comment_state_id").should have_content("Open")
    find("#comment_state_id").should have_content("Close")
  end
end
