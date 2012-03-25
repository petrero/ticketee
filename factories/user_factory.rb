Factory.define :user do |u|
  u.sequence(:email) {|n| "user#{n}@gmail.com"}
  u.password "secret"
  u.password_confirmation {|u| u.password}
end

Factory.define :confirmed_user, :parent => :user do |user|
  user.after_create {|u| u.confirm!} 
end

Factory.define :admin_user, :parent => :confirmed_user do |user|
  user.admin true
end
