require 'spec_helper'

describe "viewing projects" do
  let(:project) {Factory(:project)}
  before do
    @projects = Array.new()
    @projects.push(project)
  end
    
  it "viewing projects" do
    visit('/')
    click_link(project.name)
    current_path.should == project_path(project)  
  end
end
