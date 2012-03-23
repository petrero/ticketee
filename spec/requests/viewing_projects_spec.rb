require 'spec_helper'

describe "viewing projects" do
  let(:project) {Factory(:project)}
  before do    
    @projects = Array.new()
    @projects.push(project)
    3.times do
      project_ =  Factory(:project)
      @projects.push(project_)
    end
  end
    
  it "viewing projects" do
    visit('/')
    @projects.each do |project|
      page.should have_css('a', :text => project.name)
    end 
    click_link(project.name)
    current_path.should == project_path(project)    
  end
end
