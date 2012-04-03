require 'spec_helper'

describe "Searchings" do
  let(:user){Factory(:confirmed_user)}
  let(:project){Factory(:project)}
  let(:ticket1){Factory(:ticket, :title => "Ticket tag", :project => project, :user => user)}
  let(:ticket2){Factory(:ticket, :title => "Ticket tagged", :project => project, :user => user)}
  
  before do
    Factory(:permission, :user => user, :thing => project, :action => "view")
    Factory(:permission, :user => user, :thing => project, :action => "tag")
    ticket1.tags = [Tag.create(:name => "ticket1_tag")]
    ticket2.tags = [Tag.create(:name => "ticket2_tag")]
    login_as(user)
    visit('/')
  end
  
  it "finding by tag" do
    click_link(project.name)
    fill_in("Search", :with => "tag:ticket1_tag")
    click_button("Search")
    page.should have_content(ticket1.title)
    page.should have_no_content(ticket2.title)
  end
  
  
end
