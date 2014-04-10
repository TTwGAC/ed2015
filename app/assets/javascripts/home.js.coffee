# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  if $('#clock')
    seconds = 0
    mins = 0
    hours = 0
    scale = 450
    setInterval (->
      seconds -= 1 * scale

      #srotate = "rotate(" + seconds + "deg)"
      #$("#sec").css transform: srotate

      mins = seconds / 60
      mrotate = "rotate(" + mins + "deg)"
      $("#min").css transform: mrotate

      hours = seconds / 720
      hrotate = "rotate(" + hours + "deg)"
      $("#hour").css transform: hrotate
    ), 50

  # Countdown to GAC
  # Month is zero-indexed (3: April) and hours are offset +4 for GMT
  startDate = new Date(2014, 3, 12, 8, 0, 0);
  $('#counter').countdown({startTime: startDate})
