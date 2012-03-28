require 'spec_helper'

describe "AssigningPermissions" do
  let(:admin){Factory(:admin_user)}
  let(:user){Factory(:confirmed_user)}
  let(:project){Factory(:project)}
  
  before do
    @users = Array.new()
    @users.push(admin)
    @users.push(user) 
    @projects = Array.new()
    @projects.push(project)
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
    page.should have_content(project.name)  
  end
  
end
