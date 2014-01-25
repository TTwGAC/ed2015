$ ->
  $("tr").not(".header").hover (->
    $(this).css "background-color", "#ffd852"
  ), ->
    $(this).css "background-color", ""

