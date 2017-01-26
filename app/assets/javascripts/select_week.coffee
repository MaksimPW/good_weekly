ready = ->
$(document).on 'click', '.close-week', (e) ->
  $(this).parent().hide()
  this_monday = $(this).data('monday')
  myregexp = new RegExp(this_monday,'g');
  object_week_mondays = $(this).parent().parent().find('input#good_week_mondays')
  object_week_mondays.val(object_week_mondays.val().replace(this_monday, ''))

$(document).on 'click', '.add-week', (e) ->
  this_monday = $(this).parent().find('input#weekpicker').val().substring(0,10)
  if this_monday.length == 0
    alert('Select week!')
    return
  object_week_mondays = $(this).parent().parent().find('input#good_week_mondays')
  object_week_mondays.val(object_week_mondays.val() + ' ' + this_monday)
  $(this).parent().find('input#weekpicker').val('')
  $(this).parent().parent().find('.weeks').append("<p><a>#{this_monday}</a><a class='close close-week' data-monday='#{this_monday}'>[x]</a></p>");

# For turolinks:
$(document).ready(ready)
$(document).on('turbolinks:load', ready)