// Generated by CoffeeScript 1.6.3
(function() {
  $(document).ready(function() {
    var AjaxRequest, Controller, Dance, drawClown, human, keyMap, moonwalk, onYouTubeIframeAPIReady, server;
    $(".controller").hide();
    keyMap = {
      37: {
        direction: {
          strafe: +1
        },
        id: "left"
      },
      38: {
        direction: {
          forward: +1
        },
        id: "up"
      },
      39: {
        direction: {
          strafe: -1
        },
        id: "right"
      },
      40: {
        direction: {
          forward: -1
        },
        id: "down"
      }
    };
    Controller = (function() {
      function Controller() {}

      $(document).keydown(function(e) {
        var direction, pressed;
        pressed = keyMap[e.keyCode];
        direction = {};
        $("#" + keyMap[e.keyCode].id).addClass("selected");
        return server.get(keyMap[e.keyCode].direction);
      });

      $(document).keyup(function(e) {
        return $("#" + keyMap[e.keyCode].id).removeClass("selected");
      });

      return Controller;

    })();
    AjaxRequest = (function() {
      function AjaxRequest() {}

      AjaxRequest.prototype.get = function(input) {
        return $.ajax("http://127.0.0.1:8071/motion-control/update", {
          data: input,
          dataType: "jsonp"
        });
      };

      return AjaxRequest;

    })();
    $("#moonwalk").click(function() {
      $(".button").removeClass("button-choice");
      $(this).addClass("button-choice");
      $(".controller").fadeOut(400);
      $(".canvas-frame").fadeIn(400);
      return moonwalk.start(5000);
    });
    $("#controls").click(function() {
      $(".button").removeClass("button-choice");
      $(this).addClass("button-choice");
      $(".canvas-frame").fadeOut(400);
      return $(".controller").fadeIn(400);
    });
    Dance = (function() {
      var moves;

      function Dance() {}

      moves = [37, 38, 39, 40];

      Dance.prototype.start = function(duration) {
        var keep_dancing, start_time;
        start_time = Date.now();
        return keep_dancing = setInterval(function() {
          var current_move, now_time;
          now_time = Date.now();
          current_move = moves[Math.floor(Math.random() * moves.length)];
          if (start_time + duration <= now_time) {
            console.log("time's up");
            clearInterval(keep_dancing);
          }
          console.log("start time: " + start_time + ", now time: " + now_time);
          console.log("time left: " + (((start_time + duration) - now_time) / 1000));
          return server.get(keyMap[current_move].direction);
        }, 1000);
      };

      Dance.prototype.stopDancing = function() {
        return clearInterval(keep_dancing);
      };

      return Dance;

    })();
    moonwalk = new Dance;
    human = new Controller;
    server = new AjaxRequest;
    drawClown = function() {
      var canvas, clown, clown_loc, ctx, torso_x, torso_y;
      canvas = document.getElementById('canvas');
      ctx = canvas.getContext("2d");
      torso_x = (canvas.width - 156) / 2;
      torso_y = (canvas.height - 100) / 2;
      clown_loc = {
        source: "../hammer_bot/assets/spritesheet.png",
        torso: {
          width: 100,
          height: 105,
          position: {
            x: 415,
            y: 45
          }
        },
        head: {
          width: 122,
          height: 184,
          position: {
            x: 32,
            y: 200
          }
        },
        r_arm: {
          width: 128,
          height: 110,
          position: {
            x: 184,
            y: 58
          }
        },
        l_arm: {
          width: 170,
          height: 74,
          position: {
            x: 35,
            y: 46
          }
        }
      };
      clown = new Image();
      clown.src = clown_loc.source;
      return clown.onload = function() {
        var angle, head_x, head_y, l_arm_x, l_arm_y, r_arm_x, r_arm_y;
        head_x = torso_x - 15;
        head_y = torso_y - 96;
        r_arm_x = torso_x + 30;
        r_arm_y = torso_y - 15;
        l_arm_x = torso_x - 80;
        l_arm_y = torso_y - 4;
        ctx.drawImage(clown, clown_loc.torso.position.x, clown_loc.torso.position.y, clown_loc.torso.width, clown_loc.torso.height, torso_x, torso_y, clown_loc.torso.width, clown_loc.torso.height);
        ctx.drawImage(clown, clown_loc.head.position.x, clown_loc.head.position.y, clown_loc.head.width, clown_loc.head.height, head_x, head_y, clown_loc.head.width, clown_loc.head.height);
        ctx.drawImage(clown, clown_loc.r_arm.position.x, clown_loc.r_arm.position.y, clown_loc.r_arm.width, clown_loc.r_arm.height, r_arm_x, r_arm_y, clown_loc.r_arm.width, clown_loc.r_arm.height);
        ctx.drawImage(clown, clown_loc.l_arm.position.x, clown_loc.l_arm.position.y, clown_loc.l_arm.width, clown_loc.l_arm.height, l_arm_x, l_arm_y, clown_loc.l_arm.width, clown_loc.l_arm.height);
        angle = 0;
        return setInterval(function() {
          torso_x = Math.floor(Math.random() * (canvas.width - 230));
          torso_y = Math.floor(Math.random() * (canvas.width - 110));
          head_x = torso_x - 15;
          head_y = torso_y - 96;
          r_arm_x = torso_x + 30;
          r_arm_y = torso_y - 15;
          l_arm_x = torso_x - 80;
          l_arm_y = torso_y - 4;
          canvas.width = canvas.width;
          ctx.drawImage(clown, clown_loc.torso.position.x, clown_loc.torso.position.y, clown_loc.torso.width, clown_loc.torso.height, torso_x, torso_y, clown_loc.torso.width, clown_loc.torso.height);
          ctx.drawImage(clown, clown_loc.head.position.x, clown_loc.head.position.y, clown_loc.head.width, clown_loc.head.height, head_x, head_y, clown_loc.head.width, clown_loc.head.height);
          ctx.drawImage(clown, clown_loc.r_arm.position.x, clown_loc.r_arm.position.y, clown_loc.r_arm.width, clown_loc.r_arm.height, r_arm_x, r_arm_y, clown_loc.r_arm.width, clown_loc.r_arm.height);
          return ctx.drawImage(clown, clown_loc.l_arm.position.x, clown_loc.l_arm.position.y, clown_loc.l_arm.width, clown_loc.l_arm.height, l_arm_x, l_arm_y, clown_loc.l_arm.width, clown_loc.l_arm.height);
        }, 1000);
      };
    };
    drawClown();
    onYouTubeIframeAPIReady = function() {
      var player;
      return player = new YT.Player('player', {
        videoId: 'HMWAKW303pg',
        events: {
          'onReady': onPlayerReady,
          'onStateChange': onPlayerStateChange
        }
      });
    };
    onYouTubeIframeAPIReady;
    return onPlayerReady(event)(function() {
      return event.target.playVideo();
    });
  });

}).call(this);
