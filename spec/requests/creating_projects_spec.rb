require 'spec_helper'

describe "Projects" do
  describe "creating_projects" do
    it "create project with valid attributes" do
      visit('/')
      click_link("New Project")
      fill_in("Name", :with => "TextMate 2")
      click_on("Create Project")
      current_path.should == project_path(Project.find_by_name!("TextMate 2"))
      page.should have_content("Project has been created.") 
      page.should have_content("TextMate 2 - Projects - Ticketee") 
    end
    
    it "can't create a project with invalid attributes" do
      visit('/')
      click_link("New Project") 
      fill_in("Name", :with => "")
      click_on("Create Project") 
      page.should have_content("Project has not been created.")
      page.should have_content("Name can't be blank") 
    end
  end
  
end
