class Blog < ApplicationRecord
  enum status: { draft: 0, published: 1 }
  extend FriendlyId
  # this will cause Rails to automatically generate a URl for any title entered on a blog post
  friendly_id :title, use: :slugged

  validates_presence_of :title, :body
  belongs_to :topic
  has_many :comments, dependent: :destroy
  
  scope :new_first, lambda { order("updated_at DESC") }

  def self.special_blogs
    all
  end

  def self.featured_blogs
    limit(2)
  end



end