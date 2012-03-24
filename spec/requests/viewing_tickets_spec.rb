require 'spec_helper'

describe "ViewingTickets" do
  let(:text_mate_project){Factory(:project, :name => "TextMate 2")}
  let(:ie_project){Factory(:project, :name => "Internet Explorer")}
  let(:text_mate_ticket){Factory(:ticket, :project => text_mate_project, :title => "Make it shiny!", :description => "Gradients! Starbursts! Oh my!")}
  let(:ie_ticket){Factory(:ticket, :project => ie_project, :title => "Standards compliance!", :description => "Isn't a joke.")}
  before do
    @projects = Array.new()
    @projects.push(text_mate_project)
    @projects.push(ie_project)
    @tickets = Array.new()
    @tickets.push(text_mate_ticket)
    @tickets.push(ie_ticket)
    visit('/')
  end
  
  it "viewing tickets for a given project" do
    click_link(text_mate_project.name)
    page.should have_content(text_mate_ticket.title)
    page.should have_no_content(ie_ticket.title)
    click_link(text_mate_ticket.title)
    page.should have_css("#ticket h2", :text => text_mate_ticket.title)
    page.should have_content(text_mate_ticket.description)
    
    click_link("Ticketee")
    click_link(ie_project.name)
    page.should have_content(ie_ticket.title)
    page.should have_no_content(text_mate_ticket.title)
    click_link(ie_ticket.title)
    page.should have_css("#ticket h2", :text => ie_ticket.title)
    page.should have_content(ie_ticket.description)
  end
  
end
