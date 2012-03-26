require 'spec_helper'

describe "Links should be hidden from users who can't act on them" do
  let(:user){Factory(:confirmed_user)}
  let(:admin_user){Factory(:admin_user)}
  let(:project){Factory(:project)}
  
  before do
    @projects = Array.new()
    @projects.push(project)
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
  
  it "edit project links is hidden from non-signed-in users" do
    visit('/')
    click_link(project.name)
    page.should have_no_css('a', :text => "Edit Project")
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
  
  it "delete project links is hidden from non-signed-in users" do
    visit('/')
    click_link(project.name)
    page.should have_no_css('a', :text => "Delete Project")
  end
  
  it "delete project links is hidden fron signed-in users" do
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
end
