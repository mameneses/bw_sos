# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$.rails.allowAction = (element) ->
  message = element.data('confirm')
  return true unless message
  # Clone the clicked element (probably a delete link) so we can use it in the dialog box.
  $link = element.clone()
    # We don't necessarily want the same styling as the original link/button.
    .removeAttr('class')
    # We don't want to pop up another confirmation (recursion)
    .removeAttr('data-confirm')
    # We want a button
    .addClass('btn').addClass('btn-danger')
    # We want it to sound confirmy
    .html("Delete")

  # Create the modal box with the message
  modal_html = """
              <div class="modal fade">
                <div class="modal-dialog">
                 <div class="modal-content" id="myModal">
                   <div class="modal-header">
                     <a class="close" data-dismiss="modal">×</a>
                     <h3>#{message}</h3>
                   </div>
                   <div class="modal-body">
                     <p>Make sure because there is no going back.</p>
                   </div>
                   <div class="modal-footer">
                     <a data-dismiss="modal" class="btn">Cancel</a>
                   </div>
                 </div>
                </div>
              </div>
               """
  $modal_html = $(modal_html)
  # Add the new button to the modal box
  $modal_html.find('.modal-footer').append($link)
  # Pop it up
  $modal_html.modal()
  # Prevent the original link from working
  return false
