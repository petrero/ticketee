require 'spec_helper'

describe "Seeds" do
  let(:admin_user){Factory(:admin_user)}
  it "fill the development database" do
    load Rails.root + "db/seeds.rb"
    login_as(admin_user)
    visit('/')
    page.should have_content("Ticketee Beta")
  end
end
