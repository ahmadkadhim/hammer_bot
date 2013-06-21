$(document).ready ->

  $(document).keydown (e) ->
    direction = {}

    switch e.keyCode
      when 37
        direction = #left (strafe)
          strafe: -1

        $("#left").css("background-color","rgba(233,22,99,.8)");
      when 38
        direction = #up
          forward: 1

        $("#up").css("background-color","rgba(233,22,99,.8)");
      when 39
        direction = #right (strafe)
          strafe: 1

        $("#right").css("background-color","rgba(233,22,99,.8)");
      when 40
        direction = #down
          forward: -1
        $("#down").css("background-color","rgba(233,22,99,.8)");
      when 65 then direction = #a (turn left)
        turn: -1
        forward: 1

      when 68 then direction = #d (turn right)
        turn: 1
        forward: 1

      when 32
        direction = {}

        $("#stop").css("background-color","rgba(233,22,99,.8)");
#192.168.0.105
    $.ajax "http://127.0.0.1:8071/motion-control/update",
        data: direction
        dataType: "jsonp"

  $(document).keyup (e) ->
    $(".arrow").css("background-color","rgba(1,204,124,.6)")


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



