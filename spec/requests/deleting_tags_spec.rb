require 'spec_helper'

describe "DeletingTags" do
  let(:user){Factory(:confirmed_user)}
  let(:project){Factory(:project)}
  let(:ticket){Factory(:ticket, :user => user, :project => project)}
  
  before do
    Factory(:permission, :thing => project, :user => user, :action => "view")
    Factory(:permission, :thing => project, :user => user, :action => "tag") 
    ticket.tags = ticket.tag!("this-tag-must-die")
    @tickets = Array.new()
    @tickets.push(ticket)
    login_as(user)
    visit('/')
    click_link(project.name)
    click_link(ticket.title)
  end
  
  
  it "delete tag for this ticket", :js => true do
    click_link("delete-this-tag-must-die")
    page.should have_no_content("this-tag-must-die")    
  end
end
