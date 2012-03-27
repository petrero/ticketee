Factory.define :permission do |p|
  p.association :user
  p.association :thing, :factory => :project
  p.action "view"
end
