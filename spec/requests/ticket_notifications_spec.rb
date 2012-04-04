require 'spec_helper'

describe "TicketNotifications" do
  include EmailSpec::Helpers
  let(:bob){Factory(:confirmed_user, :email => "bob@ticketee.com")}
  let(:alice){Factory(:confirmed_user, :email => "alice@ticketee.com")}
  let(:project){Factory(:project)}
  let(:ticket){Factory(:ticket, :project => project, :user => alice)}
  
  before do
    Factory(:permission, :thing => project, :action => "view", :user => alice)
    Factory(:permission, :thing => project, :action => "view", :user => bob)
    @tickets = Array.new()
    @tickets.push(ticket)
    reset_mailer
    login_as(bob)
    visit('/')
  end
  
  it "ticket owner is automatically subscribed to a ticket" do
    click_link(project.name)
    click_link(ticket.title)
    fill_in("Text", :with => "Is it out yet?")
    click_button("Create Comment")
    unread_emails_for(alice.email).size.should == parse_email_count(1)
    
    
    open_email(alice.email)
    current_email.default_part_body.to_s.should include("updated the #{ticket.title} ticket")
    current_email.should have_subject("[ticketee] #{project.name} - #{ticket.title}")
    click_first_link_in_email
    find("#ticket h2").should have_content(ticket.title)  
  end
end