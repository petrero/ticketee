require 'spec_helper'

describe "Projects" do
  describe "creating_projects" do
    it "create project with valid attributes" do
      visit('/')
      click_link("New Project")
      fill_in("Name", :with => "TextMate 2")
      click_on("Create Project")
      page.should have_content("Project has been created.")  
    end
  end
end
