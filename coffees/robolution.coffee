$(document).ready ->

  keyMap =
    37: direction: {strafe:  +1}, id: "left"
    38: direction: {forward: +1}, id: "up"
    39: direction: {strafe:  -1}, id: "right"
    40: direction: {forward: -1}, id: "down"

  $(document).keydown (e) ->
    direction = {}
    selected = keyMap[e.keyCode]

    $("##{selected.id}").addClass("selected")

    $.ajax "http://127.0.0.1:8071/motion-control/update", #server: 192.168.0.105
        data: selected.direction
        dataType: "jsonp"

  $(document).keyup (e) ->
    $("##{selected.id}").removeClass("selected")
    # $(".arrow").css("background-color","rgba(1,204,124,.6)")






# class Dance
#   start ->
#     moves = [0,37,38,39,40,65,68]
#     e = $.Event("keydown")
#     e.which = moves[Math.floor(Math.random()*7)]
#     $(document).trigger(e)
#     console.log e




  # $("#target").on "click" ->
  #   for i in [0..10]
  #     setInterval ->
  #       dance
  #       ,4000



