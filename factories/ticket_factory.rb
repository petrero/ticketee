Factory.define :ticket do |ticket|
  ticket.sequence(:title) {|n| "ticket#{n}"}
  ticket.sequence(:description) {|n| "ticket_description#{n}"}
  ticket.association :project
  ticket.association :user
  ticket.association :state
end
