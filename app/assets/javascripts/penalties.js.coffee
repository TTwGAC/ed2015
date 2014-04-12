# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  refresh_hints = ->
    hint_list = $('#hint_list')[0]

    # Empty old hints
    hint_list.removeChild(hint_list.firstChild) while hint_list.firstChild

    puzzle_id = $('#penalty_puzzle_id')[0].value
    if puzzle_id.trim()
      $.ajax("/puzzles/#{puzzle_id}/hints.json").success (hints) ->
        $(hints).each (index) ->
          hint = hints[index]
          tr = document.createElement('tr')
          create_hint(tr, hint.hint, hint.suggested_penalty)
          hint_list.appendChild tr

  create_hint = (tr, hint_text, suggested_penalty) ->
    callback = ->
      $('#penalty_description')[0].value = hint_text
      $('#penalty_minutes')[0].value = suggested_penalty

    td = document.createElement('td')
    text = document.createTextNode hint_text
    td.appendChild text
    $(td).on 'click', callback
    tr.appendChild td

    td = document.createElement('td')
    text = document.createTextNode suggested_penalty
    td.appendChild text
    $(td).on 'click', callback
    tr.appendChild td

  $(document).ready ->
    refresh_hints()
    $('#penalty_puzzle_id').on 'change', refresh_hints
