$(document).ready ->

  keyMap =
    37: direction: {strafe:  +1}, id: "left"
    38: direction: {forward: +1}, id: "up"
    39: direction: {strafe:  -1}, id: "right"
    40: direction: {forward: -1}, id: "down"

  class PressKeys

    $(document).keydown (e) ->

      pressed = keyMap[e.keyCode]
      direction = {}

      $("##{keyMap[e.keyCode].id}").addClass("selected")

      $.ajax "http://127.0.0.1:8071/motion-control/update", #server: 192.168.0.105
          data: keyMap[e.keyCode].direction
          dataType: "jsonp"

    $(document).keyup (e) ->
      $("##{keyMap[e.keyCode].id}").removeClass("selected")
      # $(".arrow").css("background-color","rgba(1,204,124,.6)")




  # class Dance
  #   moves = [0,37,38,39,40,65,68]

  #   start: (duration) ->
  #     now = new Date





  human = new PressKeys



  # moonwalk = new Dance
  # moonwalk.start()






