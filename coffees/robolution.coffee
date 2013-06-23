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

    torso_x = (canvas1.width-256)/2
    torso_y = (canvas1.height-200)/2

    clown_loc =
      source: "../hammer_bot/assets/spritesheet.png"
      torso:
        width: 100
        height: 103
        position:
          x: 430
          y: 50
      head:
        width: 115
        height: 93
        position:
          x: -50
          y: -242
      r_arm:
        width: 80
        height: 92
        position:
          x: 250
          y: 50
      l_arm:
        width: 100
        height: 81
        position:
          x: 50
          y: 50

    clown = new Image()
    clown.src = clown_loc.source

# img, sprite-x, sprite-y,spriteWidth,spriteHeight,canvasPosX,canvasPosY, spriteWidth,spriteHeight
    clown.onload = (sprite)->
      ctx1.drawImage(clown, clown_loc.torso.position.x, clown_loc.torso.position.y, clown_loc.torso.width, clown_loc.torso.height, torso_x, torso_y, clown_loc.torso.width, clown_loc.torso.height)
      ctx1.drawImage(clown, clown_loc.head.position.x, clown_loc.head.position.y, clown_loc.head.width, clown_loc.head.height, torso_x, torso_y, clown_loc.head.width, clown_loc.head.height)
      ctx1.drawImage(clown, clown_loc.r_arm.position.x, clown_loc.r_arm.position.y, clown_loc.r_arm.width, clown_loc.r_arm.height, torso_x, torso_y, clown_loc.r_arm.width, clown_loc.r_arm.height)
      ctx1.drawImage(clown, clown_loc.l_arm.position.x, clown_loc.l_arm.position.y, clown_loc.l_arm.width, clown_loc.l_arm.height, torso_x, torso_y, clown_loc.l_arm.width, clown_loc.l_arm.height)

      angle = 0
      setInterval ->
        torso_x = Math.floor(Math.random()*(canvas1.width-256))
        torso_y = Math.floor(Math.random()*(canvas1.width-200))
        canvas1.width = canvas1.width
        ctx1.drawImage(torso, torso_x, torso_y)
        angle += 20
        # ctx1.drawImage(head, torso_x-12, torso_y-56)
        rotateImage(head, torso_x-12, torso_y-56,head.width,head.height,angle)
        rotateImage(r_arm, torso_x+81, torso_y-27,r_arm.width,r_arm.height,angle)
        rotateImage(l_arm, torso_x-80, torso_y-4,l_arm.width,l_arm.height,angle)

      , 300


    rotateImage = (img,x,y,width,height,deg) ->
      rad = (deg * Math.PI) / 180
      ctx1.translate(x + width / 2, y + height / 2)
      ctx1.rotate(rad)
      ctx1.drawImage(img,width / 2 * (-1),height / 2 * (-1),width,height)

      ctx1.rotate(rad * ( -1 ) );
      ctx1.translate((x + width / 2) * (-1), (y + height / 2) * (-1))




  drawClown()


