Factory.define :ticket do |ticket|
  ticket.sequence(:title) {|n| "aaaaaaa#{n}"}
  ticket.sequence(:description) {|n| "bbbbbbbbbb#{n}"}
  ticket.association :project
  ticket.association :user
end
