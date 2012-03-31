require 'spec_helper'

describe "ManagingStates" do
  let(:admin){Factory(:admin_user)}
  
  before do
    load Rails.root + "db/seeds.rb"
    login_as(admin)
    visit('/')
  end
  
  it "marking a state as default" do
    click_link("Admin")
    click_link("States")
    within("#state_new") do
      click_link("Make Default")
    end  
    page.should have_content("New is now the default state.")
  end
  
  it "after marking state as default only one state is default" do
    click_link("Admin")
    click_link("States")
    within("#state_new") do
      click_link("Make Default")
    end
    find("#state_new").should have_content("Default")
    within("#state_open") do
      click_link("Make Default")
    end 
    page.should have_content("Open is now the default state.") 
    find("#state_open").should have_content("Default")
    find("#state_new").should have_css('a', :text => "Make Default")
  end
end
