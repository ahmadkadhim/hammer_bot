$(document).ready ->

  $(".controller").hide()
  $("#youtube").hide()
  $(".canvas-frame").hide()

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
    bigtop = new MusicPlayer
    bigtop.startPlaying()
  $("#controls").click ->
    $(".button").removeClass("button-choice")
    $(this).addClass("button-choice")
    $(".canvas-frame").fadeOut(400)
    $(".controller").fadeIn(400)

# -----ROBOT DANCE -----
  class robotDance
    moves = [37,38,39,40] # ,65,68,0]  aren't in the keyMap yet
    start:(duration) ->      # duration is in ms
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

# -------DRAW CLOWN TO CANVAS : NOT O.O.  --------
  drawClown = ->
    canvas = document.getElementById('canvas');
    ctx = canvas.getContext("2d")
    ctx.font = "bold 80pt Calibri"
    ctx.fillText "Clown", 130, 130
    ctx.fillText "Dance!", 120, 250

    clown_loc =       # sprite sheet with location of clown parts
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

    # drawImage(spritesheet,srcX,srcY,srcW,srcH,destX,destY,destW,destH)
    clown.onload = ->
      torso_x = 300       # (canvas.width-156)/2
      torso_y = 200       # (canvas.height-100)/2
      head_x = torso_x - 15
      head_y = torso_y - 96
      r_arm_x = torso_x + 30
      r_arm_y = torso_y - 15
      l_arm_x = torso_x - 80
      l_arm_y = torso_y - 4

      ctx.drawImage(clown, clown_loc.torso.position.x, clown_loc.torso.position.y, clown_loc.torso.width, clown_loc.torso.height, torso_x, torso_y, clown_loc.torso.width, clown_loc.torso.height)
      ctx.drawImage(clown, clown_loc.head.position.x, clown_loc.head.position.y, clown_loc.head.width, clown_loc.head.height, head_x, head_y, clown_loc.head.width, clown_loc.head.height)
      ctx.drawImage(clown, clown_loc.r_arm.position.x, clown_loc.r_arm.position.y, clown_loc.r_arm.width, clown_loc.r_arm.height, r_arm_x, r_arm_y, clown_loc.r_arm.width, clown_loc.r_arm.height)
      ctx.drawImage(clown, clown_loc.l_arm.position.x, clown_loc.l_arm.position.y, clown_loc.l_arm.width, clown_loc.l_arm.height, l_arm_x, l_arm_y, clown_loc.l_arm.width, clown_loc.l_arm.height)

      angle = 0
      setInterval ->
        # randomize!!!!!!

        console.log "canvas width: #{canvas.width} and height #{canvas.height}"
        # torso_x = Math.floor(Math.random()* 3)  #(canvas.width-230))
        # torso_y = Math.floor(Math.random()* 3)  #(canvas.width-110))
        center_x = 300              # (canvas.width/2) - (clown_loc.torso.width/2)
        center_y = 200              # (canvas.height/2) - (clown_loc.torso.height/2)
               #center_x, center_y)
        torso_x = 210
        torso_y = 110
        r_arm_x = torso_x + 30
        r_arm_y = torso_y - 15
        l_arm_x = torso_x - 80
        l_arm_y = torso_y - 4

        to_rad = Math.PI / 180
        canvas.width = canvas.width
        ctx.drawImage(clown, clown_loc.torso.position.x, clown_loc.torso.position.y, clown_loc.torso.width, clown_loc.torso.height, torso_x, torso_y, clown_loc.torso.width, clown_loc.torso.height)
        ctx.drawImage(clown, clown_loc.r_arm.position.x, clown_loc.r_arm.position.y, clown_loc.r_arm.width, clown_loc.r_arm.height, r_arm_x, r_arm_y, clown_loc.r_arm.width, clown_loc.r_arm.height)
        ctx.drawImage(clown, clown_loc.l_arm.position.x, clown_loc.l_arm.position.y, clown_loc.l_arm.width, clown_loc.l_arm.height, l_arm_x, l_arm_y, clown_loc.l_arm.width, clown_loc.l_arm.height)
        ctx.save()
        ctx.translate(265,105) #head_x+(clown_loc.head.width/2) ,head_y+(clown_loc.head.height/2))
        ctx.rotate(angle*to_rad)
        ctx.drawImage(clown, clown_loc.head.position.x, clown_loc.head.position.y, clown_loc.head.width, clown_loc.head.height, -75,-85, clown_loc.head.width, clown_loc.head.height)
        ctx.translate(-265,-105)
        ctx.restore()
        angle += 1
      , 50

  class MusicPlayer
    constructor: ->
      tag = document.createElement('script')
      # tag.src = "https://www.youtube.com/iframe_api"
      tag.setAttribute("id", "youtube_api")
      firstScriptTag = document.getElementsByTagName('script')[0]
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)
    startPlaying: ->
      song = document.createElement('script')
      song.src = "js/youtube.js"
      song.setAttribute("id", "music_player")
      firstScriptTag = document.getElementsByTagName('script')[1]
      firstScriptTag.parentNode.insertBefore(song, firstScriptTag)

  moonwalk = new robotDance
  human = new Controller
  server = new AjaxRequest
  drawClown()

