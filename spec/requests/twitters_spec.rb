require 'spec_helper'

describe "Twitters" do
  before do
    OmniAuth.config.mock_auth[:twitter] = {
      "extra" => {
        "user_hash" => {
          "id" => '12345',
          "screen_name" => 'twit',
          "display_name" => "A Twit"
        }
      }
    }
  end
  
  it "signing with twitter" do
    visit('/')
    click_link('sign_in_with_twitter')
    page.should have_content("Signed in with Twitter successfully.")
    page.should have_content("Signed in as A Twit (@twit)")
  end
end
