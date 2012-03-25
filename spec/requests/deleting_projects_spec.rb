require 'spec_helper'

describe "DeletingProjects" do
  let(:admin){Factory(:admin_user)}
  let(:project) {Factory(:project)}
  before do
    @projects = Array.new()
    @projects.push(project)
    login_as(admin)
  end
  
  it "deleting project" do
    visit('/')
    click_link(project.name)
    click_link("Delete Project")
    page.should have_content("Page has been deleted.")
    page.should have_no_content(project.name)
  end
end
