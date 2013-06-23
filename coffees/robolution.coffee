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

    torso_x = (canvas.width-156)/2
    torso_y = (canvas.height-100)/2

    clown_loc =
      source: "../hammer_bot/assets/spritesheet.png"
      torso:
        width: 100
        height: 105
        position:
          x: 415
          y: 45
      head:
        width: 122
        height: 184
        position:
          x: 32
          y: 200  #238 ?? (image disappears if it goes too high)
      r_arm:
        width: 128
        height: 110
        position:
          x: 184
          y: 58
      l_arm:
        width: 170
        height: 74
        position:
          x: 35
          y: 46

    clown = new Image()
    clown.src = clown_loc.source
    head_x = torso_x - 15
    head_y = torso_y - 96

    r_arm_x = torso_x + 30
    r_arm_y = torso_y - 15

    l_arm_x = torso_x - 80
    l_arm_y = torso_y - 4

# img, sprite-x, sprite-y,spriteWidth,spriteHeight,canvasPosX,canvasPosY, spriteWidth,spriteHeight
    clown.onload = ->
      ctx.drawImage(clown, clown_loc.torso.position.x, clown_loc.torso.position.y, clown_loc.torso.width, clown_loc.torso.height, torso_x, torso_y, clown_loc.torso.width, clown_loc.torso.height)
      ctx.drawImage(clown, clown_loc.head.position.x, clown_loc.head.position.y, clown_loc.head.width, clown_loc.head.height, head_x, head_y, clown_loc.head.width, clown_loc.head.height)
      ctx.drawImage(clown, clown_loc.r_arm.position.x, clown_loc.r_arm.position.y, clown_loc.r_arm.width, clown_loc.r_arm.height, r_arm_x, r_arm_y, clown_loc.r_arm.width, clown_loc.r_arm.height)
      ctx.drawImage(clown, clown_loc.l_arm.position.x, clown_loc.l_arm.position.y, clown_loc.l_arm.width, clown_loc.l_arm.height, l_arm_x, l_arm_y, clown_loc.l_arm.width, clown_loc.l_arm.height)

      # angle = 0
      # setInterval ->
      #   torso_x = Math.floor(Math.random()*(canvas.width-256))
      #   torso_y = Math.floor(Math.random()*(canvas.width-200))
      #   canvas.width = canvas.width
      #   # ctx.drawImage(torso, torso_x, torso_y)
      #   angle += 20
      #   # # ctx.drawImage(head, torso_x-12, torso_y-56)
      #   # rotateImage(head, torso_x-12, torso_y-56,head.width,head.height,angle)
      #   # rotateImage(r_arm, torso_x+81, torso_y-27,r_arm.width,r_arm.height,angle)
      #   # rotateImage(l_arm, torso_x-80, torso_y-4,l_arm.width,l_arm.height,angle)
      #   rotateImage(clown, clown_loc.l_arm.position.x, clown_loc.l_arm.position.y, clown_loc.l_arm.width, clown_loc.l_arm.height, torso_x, torso_y, clown_loc.l_arm.width, clown_loc.l_arm.height)

      # , 1000


    rotateImage = (img,x,y,width,height,deg) ->
      rad = (deg * Math.PI) / 180
      ctx.translate(x + width / 2, y + height / 2)
      ctx.rotate(rad)
      ctx.drawImage(img,width / 2 * (-1),height / 2 * (-1),width,height)

      ctx.rotate(rad * ( -1 ) );
      ctx.translate((x + width / 2) * (-1), (y + height / 2) * (-1))




  drawClown()


