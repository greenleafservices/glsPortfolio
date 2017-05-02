class CommentBroadcastJob < ApplicationJob
  # make a list of things to do
  queue_as :default
  
  # create a perform method for the comment - called from the comments model 
  def perform(comment)
    # create a channel for the broadcast for each blog comment and show the comment using render_comment below
    ActionCable.server.broadcast "blogs_#{comment.blog.id}_channel", comment: render_comment(comment)
  end

  private

  def render_comment(comment)
    # communicate with Rails through the Comments controller
    CommentsController.render partial: 'comments/comment', locals: { comment: comment }
  end
end