require 'spec_helper'

describe "EditingProjects" do
  let(:project) {Factory(:project)}
  before do
    @projects = Array.new()
    @projects.push(project)
  end
  
  it "update a project with valid attributes" do
    visit('/')
    click_link(project.name)
    click_link("Edit Project")
    fill_in("Name", :with => "Text Mate 2 Beta")
    click_on("Update Project")
    page.should have_content("Project has been updated.")
    current_path.should == project_path(Project.find_by_name("Text Mate 2 Beta"))
  end
  
  it "don't update a project with invalid attributes" do
    visit('/')
    click_link(project.name)
    click_link("Edit Project")
    fill_in("Name", :with => "")
    click_on("Update Project")
    page.should have_content("Project has not been updated.")
  end
end
