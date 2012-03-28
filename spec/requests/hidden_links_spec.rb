require 'spec_helper'

describe "Links should be hidden from users who can't act on them" do
  let(:user){Factory(:confirmed_user)}
  let(:admin_user){Factory(:admin_user)}
  let(:project){Factory(:project)}
  let(:ticket){Factory(:ticket, :project => project, :user => user)}
  
  before do
    @projects = Array.new()
    @projects.push(project)
    @tickets = Array.new()
    @tickets.push(ticket)
    Factory(:permission, :thing => project, :user => user, :action => "view")
  end
  
  it "new project links is hidden from non-signed-in users" do
    visit('/')
    page.should have_no_css('a', :text => "New Project")
  end
  
  it "new project links is hidden fron signed-in users" do
    login_as(user)
    visit('/')
    page.should have_no_css('a', :text => "New Project")  
  end
  
  it "show new project links to admins" do
    login_as(admin_user)
    visit('/')
    page.should have_css('a', :text => "New Project") 
  end
  
  
  it "edit project links is hidden fron signed-in users" do
    login_as(user)
    visit('/')
    click_link(project.name)
    page.should have_no_css('a', :text => "Edit Project")  
  end
  
  it "show edit project links to admins" do
    login_as(admin_user)
    visit('/')
    click_link(project.name)
    page.should have_css('a', :text => "Edit Project") 
  end
  
  
  it "delete project links is hidden from signed-in users" do
    login_as(user)
    visit('/')
    click_link(project.name)
    page.should have_no_css('a', :text => "Delete Project")  
  end
  
  it "show delete project links to admins" do
    login_as(admin_user)
    visit('/')
    click_link(project.name)
    page.should have_css('a', :text => "Delete Project") 
  end
  
  it "new ticket link is shown to  a user with permission" do
    Factory(:permission, :thing => project, :user => user, :action => "create tickets")
    login_as(user)
    visit('/')
    click_link(project.name)
    page.should have_css('a', :text => "New Ticket")
  end
 
  it "new ticket link is hidden from a user without permission" do
    login_as(user)
    visit('/')
    click_link(project.name)
    page.should have_no_css('a', :text => "New Ticket")
  end
  
  it "new ticket is shown to an admin user" do
    login_as(admin_user)
    visit('/')
    click_link(project.name)
    page.should have_css('a', :text => "New Ticket")
  end
  
  it "edit ticket link is shown to  a user with permission" do
    Factory(:permission, :thing => project, :user => user, :action => "edit tickets")
    login_as(user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    page.should have_css('a', :text => "Edit Ticket")
  end
 
  it "edit ticket link is hidden from a user without permission" do
    login_as(user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    page.should have_no_css('a', :text => "Edit Ticket")
  end
  
  it "edit ticket is shown to an admin user" do
    login_as(admin_user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    page.should have_css('a', :text => "Edit Ticket")
  end
  
  
  it "delete ticket link is shown to  a user with permission" do
    Factory(:permission, :thing => project, :user => user, :action => "delete tickets")
    login_as(user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    page.should have_css('a', :text => "Delete Ticket")
  end
 
  it "delete ticket link is hidden from a user without permission" do
    login_as(user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    page.should have_no_css('a', :text => "Delete Ticket")
  end
  
  it "delete ticket is shown to an admin user" do
    login_as(admin_user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    page.should have_css('a', :text => "Delete Ticket")
  end
end
