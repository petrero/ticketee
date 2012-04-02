require 'spec_helper'

describe "CreatingComments" do
  let(:user){Factory(:confirmed_user)}
  let(:project){Factory(:project, :name => "Ticketee")}
  let(:ticket){Factory(:ticket, :project => project, :user => user)}
  
  before :each do
    @projects = Array.new()
    @projects.push(project)
    @tickets = Array.new()
    @tickets.push(ticket)
    Factory(:permission, :user => user, :thing => project, :action => "view")
    login_as(user)
    visit('/')
    within("#projects") do
      click_link(project.name)
    end
  end
   
  it "creating a comment" do 
    click_link(ticket.title)  
    fill_in("Text", :with => "Added a comment!")
    click_button("Create Comment")
    page.should have_content("Comment has been created.")
    find("#comments").should have_content("Added a comment!")     
  end
  
  it "creating an invalid comment" do
    click_link(ticket.title)
    click_button("Create Comment")
    page.should have_content("Comment has not been created.") 
    page.should have_content("Text can't be blank")
  end
  
  it "Changing a ticket's state" do
    Factory(:permission, :thing => project, :user => user,:action => "change states")
    State.create(:name => "Open")
    click_link(ticket.title)
    fill_in("Text", :with => "This is a real issue")
    select("Open", :from => "State")
    click_button("Create Comment")
    page.should have_content("Comment has been created.")
    find("#ticket .state").should have_content("Open") 
    find("#comments").should have_content("Open")
  end
  
  it "a user without permission cannor change the state" do
    click_link(ticket.title) 
    page.should have_no_css("#comment_state_id")
  end
  
  it "adding a tag to a ticket" do
    click_link(ticket.title)
    fill_in("Text", :with => "Adding a bug tag")
    fill_in("Tags", :with => "bug")
    click_button("Create Comment")
    page.should have_content("Comment has been created.")
    find("#ticket #tags").should have_content("bug")  
  end
end
