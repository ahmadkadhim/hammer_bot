$(document).ready ->

  $(document).keydown (e) ->
    direction = {}

    switch e.keyCode
      when 37 then direction = #left
        forward: 1
        turn: -1

      when 38 then direction = #up
        forward: 1

      when 39 then direction = #right
        forward: 1
        turn: 1

      when 40 then direction = #down
        forward: -1

      when 65 then direction = #a (strafe)
        strafe: -1

      when 68 then direction = #d (strafe)
        strafe: 1

    $.ajax "http://192.168.0.105:8071/motion-control/update",
        data: direction
        dataType: "jsonp"

  # dance ->
  #   moves = [0,37,38,39,40,65,68]
  #   e = $.Event("keydown")
  #   e.which = moves[Math.floor(Math.random()*7)]
  #   $(document).trigger(e)


  # $("#target").on "click" ->
  #   for i in [0..10]
  #     setInterval ->
  #       dance
  #       ,4000



