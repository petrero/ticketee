require 'spec_helper'

describe "DeletingTickets" do
  let(:user){Factory(:confirmed_user)}
  let(:project){Factory(:project)}
  let(:ticket){Factory(:ticket, :project => project, :user => user)}
  
  
  before do
    @projects = Array.new()
    @projects.push(project)
    @tickets = Array.new()
    @tickets.push(ticket)
    login_as(user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    click_link("Delete Ticket")
  end
  
  it "delete project" do
    page.should have_content("Ticket has been deleted.")
    current_path.should == project_path(project)  
  end
end
