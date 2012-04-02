require 'spec_helper'

describe CommentsController do
  let(:user){Factory(:confirmed_user)}
  let(:project){Factory(:project)}
  let(:ticket){Factory(:ticket, :user => user, :project => project)}
  
  let(:state){State.create!(:name => "New")}
  
  before do
    sign_in(:user, user)
  end
  
  it "cannot transition a state by passing through state id" do
    post :create, {:comment => {:text => "Hacked!", :state_id => state.id}, :ticket_id => ticket.id}
    
    ticket.reload
    ticket.state.should eql(nil)
  end
end
