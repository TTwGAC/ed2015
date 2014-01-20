# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  addSpacer = (select_node) ->
    spacer = $(document.createElement('option'));
    spacer.append(document.createTextNode('---------------'));
    spacer.attr('disabled', 'disabled');
    select_node.append(spacer);

  addCreator = (select_node) ->
    creator = $(document.createElement('option'));
    creator.append(document.createTextNode('Create new...'));
    creator.val('__create')
    select_node.append(creator);

  addOptions = (name) ->
    select_node = $("#puzzle_#{name}_id")
    addSpacer(select_node);
    addCreator(select_node);
    select_node.change ->
      if select_node.val() == '__create'
        $("#new_#{name}").modal()

  addCallback = (name) ->
    $("#new_#{name}").bind 'ajax:success', (evt, data, status, xhr) ->
      $("#new_#{name}").modal('hide')
      $("#new_#{name}").find('form')[0].reset();
      reloadOptions(name)

  reloadOptions = (name) ->
    $.ajax "/#{name}s.json",
      dataType: "json",
      success: (data, status, xhr) ->
        refreshSelections('origin')
        refreshSelections('destination')

  refreshSelections = (name) ->
    select_node = $("#puzzle_#{name}_id")
    select_node.empty()
    highest_id = 0
    for item in data
      select_node.append("<option value=\"#{item.id}\">#{item.name}</option>")
      highest_id = item.id if item.id > highest_id
    addSpacer(select_node)
    addCreator(select_node)
    select_node.val(highest_id)
    true

  addOptions('origin')
  addOptions('destination')
  addCallback('origin')
  addCallback('destination')


