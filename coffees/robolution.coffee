$(document).ready ->

  $(".controller").hide()

  keyMap =
    37: direction: {strafe:  +1}, id: "left"
    38: direction: {forward: +1}, id: "up"
    39: direction: {strafe:  -1}, id: "right"
    40: direction: {forward: -1}, id: "down"

  class Controller
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

# --------- buttons ------------

  $("#moonwalk").click ->
    $(".button").removeClass("button-choice")
    $(this).addClass("button-choice")
    $(".controller").fadeOut(400)
    $(".canvas-frame").fadeIn(400)
    moonwalk.start(5000)

  $("#controls").click ->
    $(".button").removeClass("button-choice")
    $(this).addClass("button-choice")
    $(".canvas-frame").fadeOut(400)
    $(".controller").fadeIn(400)


  class Dance
    moves = [37,38,39,40] # ,65,68,0]  aren't in the keyMap yet

    start: (duration) ->      # duration is in ms
      start_time = Date.now()
      keep_dancing = setInterval ->
        now_time = Date.now()
        current_move = moves[Math.floor(Math.random()* moves.length )]
        if start_time + duration <= now_time
          console.log "time's up"
          # Dance.stopDancing()
          clearInterval(keep_dancing)
        console.log "start time: #{start_time}, now time: #{now_time}"
        console.log "time left: #{((start_time + duration) - now_time)/1000}"
        server.get(keyMap[current_move].direction)
        # console.log new Date.getTime
      , 1000
      # now = new Date()
      # console.log(now)

    stopDancing: ->
      clearInterval(keep_dancing)




  moonwalk = new Dance





 # create the relevant classes:
 #  since human and server are listening to window, they should never
 #  need to be interacted with

  human = new Controller
  server = new AjaxRequest

    # dimensions:   width:  580 height:   340

  drawClown = ->
    canvas = document.getElementById('canvas');
    ctx = canvas.getContext("2d")

    xpos = (canvas.width-256)/2
    ypos = (canvas.height-200)/2
    # clown_width = 256
    # clown_height = 200
    # clown = new Image()
    # clown.src = "../hammer_bot/assets/clown.png"

    clowns =
      torso:
        source: "../hammer_bot/assets/clown_torso_100.png"
        # width:
        # height:
      head:
        source: "../hammer_bot/assets/clown_head.png"
        # width:
        # height:
      r_arm:
        source: "../hammer_bot/assets/clown_Rarm.png"
        # width:
        # height:
      l_arm:
        source:"../hammer_bot/assets/clown_Larm.png"
        # width:
        # height:

    torso = new Image()
    torso.src = clowns.torso.source

    head = new Image()
    head.src = clowns.head.source

    torso.onload = ->
      ctx.drawImage(torso, xpos, ypos)
    head.onload = ->
      ctx.drawImage(head, xpos-12, ypos-56)
      # ctx.drawImage(clown_head, xpos, ypos, clown_width, clown_height)
      # ctx.drawImage(clown_Rarm, xpos, ypos, clown_width, clown_height)
      # ctx.drawImage(clown_Larm, xpos, ypos, clown_width, clown_height)


      setInterval ->
        xpos = Math.floor(Math.random()*(canvas.width-256))
        ypos = Math.floor(Math.random()*(canvas.width-200))
        ctx.drawImage(clown, xpos, ypos, clown_width, clown_height)
        ctx.rotate(0.17)
      , 1000




  drawClown()


