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
    save_and_open_page
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
end
