class Topic < ApplicationRecord
  validates_presence_of :title

  has_many :blogs
  
  def self.with_blogs
    # find the blogs that have topics associated with them
    includes(:blogs).where.not(blogs: { id: nil })
  end
  
  def self.by_alpha
    # find the blogs that have topics associated with them
     order("title ASC")
  end
  
end