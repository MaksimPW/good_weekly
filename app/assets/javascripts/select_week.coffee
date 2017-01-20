ready = ->
$(document).on 'click', '.close-week', (e) ->
  $(this).parent().hide()
  this_monday = $(this).data('monday')
  myregexp = new RegExp(this_monday,'g');
  object_week_mondays = $(this).parent().parent().find('input#good_week_mondays')
  object_week_mondays.val(object_week_mondays.val().replace(this_monday, ''))

# For turolinks:
$(document).ready(ready)
$(document).on('turbolinks:load', ready)