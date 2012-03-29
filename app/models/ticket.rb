class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  has_attached_file :asset
  validates :title, :presence => true
  validates :description, :presence => true
end
