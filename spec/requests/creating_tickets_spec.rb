require 'spec_helper'

describe "CreatingTickets" do
  let(:ie_project) {Factory(:project, :name => "Internet Explorer")}
  
  before do
    @projects = Array.new()
    @projects.push(ie_project)
    visit('/')
    click_link(ie_project.name)
    click_link("New Ticket")
  end
  
  it "create a ticket with valid attributes" do
    fill_in("Title", :with => "Non-standards compliance")
    fill_in("Description", :with => "My pages are ugly!")
    click_on("Create Ticket")
    page.should have_content("Ticket has been created.")
  end
  
  it "don't create a ticket with invalid attributes" do
    click_on("Create Ticket")
    page.should have_content("Ticket has not been created.")
    page.should have_content("Title can't be blank")
    page.should have_content("Description can't be blank")
  end
end
