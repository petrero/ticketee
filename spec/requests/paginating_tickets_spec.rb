require 'spec_helper'

describe "PaginatingTickets" do
  let(:user){Factory(:confirmed_user)}
  let(:project){Factory(:project)}
  
  before do
    Factory(:permission, :thing => project, :action => "view", :user => user)
    login_as(user)
    100.times do
      Factory(:ticket, :project => project)      
    end
    visit('/')
    click_link(project.name) 
  end
  
  it "viewing the second page" do
    pages = all(".pagination .page")
    pages.count.should eql(2)
    within('.pagination .next') do
      click_link("Next") 
    end 
    current_page = find('.pagination .current').text.strip.to_i
    current_page.should eql(2)
  end
end
