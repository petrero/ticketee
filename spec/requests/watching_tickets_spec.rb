require 'spec_helper'

describe "WatchingTickets" do
  let(:user){Factory(:confirmed_user)}
  let(:project){Factory(:project)}
  let(:ticket){Factory(:ticket, :project => project, :user => user)}
  
  before do
    Factory(:permission, :thing => project, :action => "view", :user => user)
    @tickets = Array.new()
    @tickets.push(ticket)
    login_as(user)
    visit('/')
  end
  
  it "ticket watching toggling" do
    click_link(project.name)
    click_link(ticket.title)
    find("#watchers").should have_content(user.email)
    click_button("Stop watching this ticket")
    page.should have_content("You are no longer watching this ticket")
    find("#watchers").should have_no_content(user.email)
  end
end
