class Ticket < ActiveRecord::Base
  searcher do
    label :tag, :from => :tags, :field => :name
  end
  belongs_to :project
  belongs_to :user
  belongs_to :state
  
  validates :title, :presence => true
  validates :description, :presence => true
  
  has_many :assets
  accepts_nested_attributes_for :assets
  has_many :comments
  
  has_and_belongs_to_many :tags
  
  def tag!(tags)
    tags = tags.split(" ").map {|tag|
      Tag.find_or_create_by_name(tag)
    }
    self.tags << tags
  end
end
