class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  
  
  validates :title, :presence => true
  validates :description, :presence => true
  
  has_many :assets
  accepts_nested_attributes_for :assets
end
