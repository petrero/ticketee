require 'spec_helper'

describe "EditingTickets" do
  let(:user) {Factory(:confirmed_user)}
  let(:project){Factory(:project)}
  let(:ticket){Factory(:ticket, :project => project, :user => user)}
  
  before :each do
    @projects = Array.new()
    @projects.push(project)
    @tickets = Array.new()
    @tickets.push(ticket)
    login_as(user)
    visit('/')  
    click_link(project.name)
    click_link(ticket.title)
    click_link("Edit Ticket")
  end
  
  
  it "update ticket with valid attributes" do 
    fill_in("Title", :with => "TextMate 2")
    click_on("Update Ticket")
    page.should have_content("Ticket has been updated.")
    page.should have_css("#ticket h2", :text => "TextMate 2")
    page.should have_no_content(ticket.title)
  end
  
  it "don't update ticket with invalid attributes" do
    fill_in("Title", :with => "") 
    click_on("Update Ticket") 
    page.should have_content("Ticket has not been updated.")
  end
end
