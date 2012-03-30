class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  belongs_to :state
  
  validates :title, :presence => true
  validates :description, :presence => true
  
  has_many :assets
  accepts_nested_attributes_for :assets
  has_many :comments
end
