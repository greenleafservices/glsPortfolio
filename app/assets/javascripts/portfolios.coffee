ready = undefined
set_positions = undefined

# The set_positions routine gets the present card setup on the calling page and assigns a position number to each card
set_positions = ->
  $('.card').each (i) ->
    $(this).attr 'data-pos', i + 1
    return
  return

ready = ->
  # Call the set_positions function
  set_positions()

  $('.sortable').sortable()
  # ****************************        Perform the sorting update using the html5 sortable library
  $('.sortable').sortable().bind 'sortupdate', (e, ui) ->
    updated_order = [] # empty array to store the order
    set_positions() # refresh the order
    $('.card').each (i) -> # run through the card data
      updated_order.push  # set the new order from the cards into the array
        id: $(this).data('id')
        newposition: i + 1
      return
    $.ajax # communicate with rails directly
      type: 'PUT' #type of communication - part of rails routes - used for updating values in the database
      url: '/portfolios/sort' #where we are communucating to - action in the portfolio controller
      data: order: updated_order # send the new order array to the controller
    return
  # **********************************************************
  return

$(document).ready ready
