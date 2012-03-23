Factory.define :project do |project|
  project.sequence(:name) {|n| "aaaaaaa#{n}"}
end
