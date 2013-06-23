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
    canvas1 = document.getElementById('canvas1');
    ctx1 = canvas1.getContext("2d")

    xpos = (canvas1.width-256)/2
    ypos = (canvas1.height-200)/2
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

    r_arm = new Image()
    r_arm.src = clowns.r_arm.source

    l_arm = new Image()
    l_arm.src = clowns.l_arm.source

    torso.onload = ->
      ctx1.drawImage(torso, xpos, ypos)
    head.onload = ->
      ctx1.drawImage(head, xpos-12, ypos-56)
    r_arm.onload = ->
      ctx1.drawImage(r_arm, xpos+81, ypos-27)
    l_arm.onload = ->
      ctx1.drawImage(l_arm, xpos-80, ypos-4)

      angle = 0
      setInterval ->
        # xpos = Math.floor(Math.random()*(canvas1.width-256))
        # ypos = Math.floor(Math.random()*(canvas1.width-200))
        canvas1.width = canvas1.width
        ctx1.drawImage(torso, xpos, ypos)
        angle += 20
        # ctx1.drawImage(head, xpos-12, ypos-56)
        rotateImage(head, xpos-12, ypos-56,head.width,head.height,angle)
        rotateImage(r_arm, xpos+81, ypos-27,r_arm.width,r_arm.height,angle)
        rotateImage(l_arm, xpos-80, ypos-4,l_arm.width,l_arm.height,angle)

      , 100


    rotateImage = (img,x,y,width,height,deg) ->
      rad = (deg * Math.PI) / 180
      ctx1.translate(x + width / 2, y + height / 2)
      ctx1.rotate(rad)
      ctx1.drawImage(img,width / 2 * (-1),height / 2 * (-1),width,height)

      ctx1.rotate(rad * ( -1 ) );
      ctx1.translate((x + width / 2) * (-1), (y + height / 2) * (-1))




  drawClown()


