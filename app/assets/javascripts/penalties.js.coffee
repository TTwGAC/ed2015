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
        console.log hints
        $(hints).each (hint) ->
          hint = hints[hint]
          tr = document.createElement('tr')
          tr.appendChild add_field(tr, hint.hint)
          tr.appendChild add_field(tr, hint.suggested_penalty)
          hint_list.appendChild tr

  add_field = (tr, content) ->
    td = document.createElement('td')
    text = document.createTextNode content
    td.appendChild text
    td
    
  $('#penalty_puzzle_id').on 'change', refresh_hints

  refresh_hints
