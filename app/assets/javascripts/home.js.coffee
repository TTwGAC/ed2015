# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  
  # Countdown to GAC
  # Month is zero-indexed (3: April) and hours are offset +4 for GMT
  #startDate = new Date(2015, 3, 11, 8, 0, 0);
  #$('#counter').countdown({startTime: startDate})
  cdown = new CDown();
  cdown.add(new Date(2015,3,11,9,0,0), 'counter');
  #$('#counter').countdown '2020/10/10', (event) ->
  #  $(this).html(event.strftime('%D days %H:%M:%S'))