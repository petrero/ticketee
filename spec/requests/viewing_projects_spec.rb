require 'spec_helper'

describe "viewing projects" do
  let(:project) {Factory(:project)}
  let(:user){Factory(:confirmed_user)}
  before do    
    Factory(:permission, :thing => project, :action => "view", :user => user)   
  end
    
  it "viewing projects" do
    visit('/')
    page.should have_no_content(project.name)
    login_as(user)
    visit('/')
    click_link(project.name)
    current_path.should == project_path(project)    
  end
end
