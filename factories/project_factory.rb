Factory.define :project do |project|
  project.sequence(:name) {|n| "project#{n}"}
end
