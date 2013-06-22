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
      server.get(keyMap[e.keyCode].direction)

    $(document).keyup (e) ->
      $("##{keyMap[e.keyCode].id}").removeClass("selected")



  class AjaxRequest     # ----- server is at : 192.168.0.105 ------
    get: (input) ->
      $.ajax "http://127.0.0.1:8071/motion-control/update",
        data: input
        dataType: "jsonp"



  # class Dance
  #   moves = [0,37,38,39,40,65,68]

  #   start: (duration) ->
  #     now = new Date





  human = new PressKeys
  server = new AjaxRequest



  # moonwalk = new Dance
  # moonwalk.start()






