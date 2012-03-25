Factory.define :user do |u|
  u.sequence(:email) {|n| "user#{n}@gmail.com"}
  u.password "secret"
  u.password_confirmation {|u| u.password}
end

Factory.define :confirmed_user, :class => :user do |user|
  Factory(:user)
  user.confirm!
end
