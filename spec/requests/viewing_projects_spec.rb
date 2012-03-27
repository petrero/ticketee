require 'spec_helper'

describe "viewing projects" do
  let(:project) {Factory(:project)}
  let(:user){Factory(:confirmed_user)}
  before do    
    @projects = Array.new()
    @projects.push(project)
    Factory(:permission, :thing => project, :action => "view", :user => user)
    login_as(user)
  end
    
  it "viewing projects" do
    visit('/')
    click_link(project.name)
    current_path.should == project_path(project)    
  end
end
