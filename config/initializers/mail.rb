ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => "587",
  :domain => "gmail.com",
  :enable_starttls_auto => true,
  :authentication => :login,
  :user_name => "xxxxxxxxxx@gmail.com",
  :password => "xxxxxxxxxx"
}


