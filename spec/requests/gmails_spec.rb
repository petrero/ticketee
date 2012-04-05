require 'spec_helper'

describe "Gmails" do
  let(:alice){Factory(:confirmed_user)}
  let(:me){Factory(:confirmed_user, :email => "xxxxxxxxx@gmail.com", :password => "wwwwwwwww")}
  let(:project){Factory(:project)}
  let(:ticket) {Factory(:ticket, :project => project, :user => me)}

  before do  
    ActionMailer::Base.delivery_method = :smtp 
    Factory(:permission, :user => alice, :thing => project, :action => "view")
    Factory(:permission, :user => me, :thing => project, :action => "view")
    @tickets = Array.new()
    @tickets.push(ticket)
  end
  
  it "Receiving a real-world email" do
    login_as(alice)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    fill_in("Text", :with => "Posting a comment!")
    click_button("Create Comment")
    page.should have_content("Comment has been created.")
    
    @gmail = Gmail.connect(me.email, me.password) 
    
    @mails = @gmail.inbox.find(:unread, :from => "xxxxxxxxx@gmail.com") do |mail|
      if mail.subject =~ /^\[ticketee\]/
        mail.delete!
        @received_mail = true
      end
    end 
    @received_email.should be_true
  end
end
