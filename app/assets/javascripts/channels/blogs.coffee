jQuery(document).on 'turbolinks:load', ->
  # Use the comments id blogs show to find the comments to work with
  # and store and comments in the comments variable 
  comments = $('#comments') 
  # If there are comments available
  if comments.length > 0
    # call ActionCable and create a subscription (connection) to it
    App.global_chat = App.cable.subscriptions.create {
      channel: "BlogsChannel"
      # Get the blog id from the blog show page (in the div wrapping the @blog.comments)
      blog_id: comments.data('blog-id')
    },
    # tell the script what to do for each of the states of the subscription
    connected: ->
    disconnected: ->
    received: (data) ->
      # add the comment from the blog to the comment data. This will allow the 
      # comment section to be updated without reloading the page
      comments.append data['comment']
    send_comment: (comment, blog_id) ->
      @perform 'send_comment', comment: comment, blog_id: blog_id
  # end of if block
  # Now, add the new comment to the end of the data already received from the show page
  # when the submit button is pressed (an (e)vent)
  $('#new_comment').submit (e) ->
    # we want to use a data instance $this of this event
    $this = $(this) 
    # search through the (e)vent and find the content from the database record
    textarea = $this.find('#comment_content')
    # if there's something in the content
    if $.trim(textarea.val()).length > 1
      # now use the BlogsChannel send_comment method to send the data
      App.global_chat.send_comment textarea.val(),
      comments.data('blog-id')
      # reset the text area to clear the submitted content
      textarea.val('')
      # prevent the form from reloading
    e.preventDefault()
  return false
