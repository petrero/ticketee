require 'spec_helper'

describe "CreatingTickets" do
  let(:ie_project) {Factory(:project, :name => "Internet Explorer")}
  let(:user){Factory(:confirmed_user)}
  
  before do
    @projects = Array.new()
    @projects.push(ie_project)
    Factory(:permission, :thing => ie_project, :user => user, :action => "view") 
    Factory(:permission, :thing => ie_project, :user => user, :action => "create tickets")
    login_as(user)
    visit('/')
    click_link(ie_project.name)   
    click_link("New Ticket")
  end
  
  it "create a ticket with valid attributes" do
    fill_in("Title", :with => "Non-standards compliance")
    fill_in("Description", :with => "My pages are ugly!")
    click_on("Create Ticket")
    page.should have_content("Ticket has been created.")
    page.should have_content("Created by " + user.email)
  end
  
  it "don't create a ticket with invalid attributes" do
    click_on("Create Ticket")
    page.should have_content("Ticket has not been created.")
    page.should have_content("Title can't be blank")
    page.should have_content("Description can't be blank")
  end
  
  
  
  it "creating a ticket with an attachment", :js => true do
    fill_in("Title", :with => "Add documentation for blink tag")
    fill_in("Description", :with => "The blank tag has an undocumented speed attribute")
    page.attach_file("File #1", "spec/fixtures/speed.txt")  
    click_link("Add another file")
    page.attach_file("File #2", "spec/fixtures/spin.txt")
    click_button("Create Ticket")
    page.should have_content("Ticket has been created.")
    find("#ticket .assets").should have_content("speed.txt")
    find("#ticket .assets").should have_content("spin.txt")
  end
  
  it "creating a ticket with tags" do
    fill_in("Title", :with => "Non-standards compliance")
    fill_in("Description", :with => "My pages are ugly!")
    fill_in("Tags", :with => "browser visual")
    click_button("Create Ticket")
    page.should have_content("Ticket has been created.")
    find("#ticket #tags").should have_content("browser")
    find("#ticket #tags").should have_content("visual")
  end
end
