require 'spec_helper'

describe "AssigningPermissions" do
  let(:admin){Factory(:admin_user)}
  let(:user){Factory(:confirmed_user)}
  let(:project){Factory(:project)}
  let(:ticket){Factory(:ticket, :user => user, :project => project)}
  
  before do
    @users = Array.new()
    @users.push(admin)
    @users.push(user) 
    @projects = Array.new()
    @projects.push(project)
    @tickets = Array.new()
    @tickets.push(ticket)
    State.create!(:name => "Open")
    login_as(admin)
    visit('/')
    click_link("Admin")
    click_link("Users")
    click_link(user.email)
    click_link("Permissions")
  end
  
  it "viewing a project" do
    page.check("permissions_#{project.id}_#{:view.to_sym}")
    click_button("Update")
    logout()    
    
    login_as(user)
    visit('/')
    page.should have_content(project.name)  
  end
  
  it "creating tickets for a project" do
    page.check("permissions_#{project.id}_view")
    page.check("permissions_#{project.id}_create_tickets") 
    click_button("Update")
    logout()
    
    login_as(user)
    visit('/')
    click_link(project.name)
    page.should have_css('a', :text => "New Ticket")  
  end
  
  it "can't create tickets for a project" do
    page.check("permissions_#{project.id}_view")
    click_button("Update")
    logout()
    
    login_as(user)
    visit('/')
    click_link(project.name)
    page.should have_no_css('a', :text => "New Ticket")  
  end
  
  it "updating a ticket for a project" do
    page.check("permissions_#{project.id}_view")
    page.check("permissions_#{project.id}_edit_tickets") 
    click_button("Update")
    logout()  
    
    login_as(user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    page.should have_css('a', :text => "Edit Ticket")
  end
  
  it "can't update a ticket for a project" do
    page.check("permissions_#{project.id}_view")
    click_button("Update")
    logout()  
    
    login_as(user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    page.should have_no_css('a', :text => "Edit Ticket")
  end
  
  it "deleting a ticket for a project" do
    page.check("permissions_#{project.id}_view")
    page.check("permissions_#{project.id}_delete_tickets") 
    click_button("Update")
    logout()  
    
    login_as(user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    page.should have_css('a', :text => "Delete Ticket")
  end
  
  it "can't delete a ticket for a project" do
    page.check("permissions_#{project.id}_view")
    click_button("Update")
    logout()  
    
    login_as(user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    page.should have_no_css('a', :text => "Delete Ticket")
  end
  
  it "changing states for a feature" do
    page.check("permissions_#{project.id}_view")
    page.check("permissions_#{project.id}_change_states")
    click_button("Update")
    logout()
    
    login_as(user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
    fill_in("Text", :with => "Opening this ticket.")
    select("Open", :from => "State")
    click_button("Create Comment")
    page.should have_content("Comment has been created.")
    find("#ticket .state").should have_content("Open")
  end
end
