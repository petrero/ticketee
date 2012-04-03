require 'spec_helper'

describe "Searchings" do
  let(:user){Factory(:confirmed_user)}
  let(:project){Factory(:project)}
  let(:ticket1_state) {Factory(:state, :name => "Open")}
  let(:ticket2_state) {Factory(:state, :name => "Closed")}
  let(:ticket1){Factory(:ticket, :title => "ticket1", :project => project, :user => user, :state => ticket1_state)}
  let(:ticket2){Factory(:ticket, :title => "ticket2", :project => project, :user => user, :state => ticket2_state)}
  
  
  before do
    Factory(:permission, :user => user, :thing => project, :action => "view")
    Factory(:permission, :user => user, :thing => project, :action => "tag")
   
    ticket1.tags = [Tag.create(:name => "ticket1_tag")]
    ticket2.tags = [Tag.create(:name => "ticket2_tag")]
    login_as(user)
    visit('/')
    click_link(project.name)
  end
  
  it "finding by tag" do   
    fill_in("Search", :with => "tag:ticket1_tag")
    click_button("Search")
    page.should have_content(ticket1.title)
    page.should have_no_content(ticket2.title)
  end
  
  it "finding by state" do
    fill_in("Search", :with => "state:Open")
    click_button("Search")
    page.should have_content(ticket1.title)
    page.should have_no_content(ticket2.title)  
  end
  
  
end
