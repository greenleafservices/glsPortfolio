
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :blog

  validates :content, presence: true, length: { minimum: 5, maximimum: 1000 }
  
  def self.recent
    order("created_at DESC")
  end
  
  after_create_commit { CommentBroadcastJob.perform_later(self) }
end