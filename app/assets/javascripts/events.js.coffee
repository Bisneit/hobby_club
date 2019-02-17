$(document).on "change", "#repeat", (e) ->
  value = @.value
  if value != 'no'
    $("#repeat_params").removeClass('hidden')
    $("#week").removeClass('hidden') if value == 'week'
    $("#days").removeClass('hidden') if value == 'day'
  else
    $("#repeat_params").addClass('hidden')
    $("#week").removeClass('hidden')
