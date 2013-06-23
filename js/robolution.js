// Generated by CoffeeScript 1.6.3
(function() {
  $(document).ready(function() {
    var AjaxRequest, Controller, Dance, drawClown, human, keyMap, moonwalk, server;
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
      var canvas1, clowns, ctx1, head, l_arm, r_arm, rotateImage, torso, xpos, ypos;
      canvas1 = document.getElementById('canvas1');
      ctx1 = canvas1.getContext("2d");
      xpos = (canvas1.width - 256) / 2;
      ypos = (canvas1.height - 200) / 2;
      clowns = {
        torso: {
          source: "../hammer_bot/assets/clown_torso_100.png"
        },
        head: {
          source: "../hammer_bot/assets/clown_head.png"
        },
        r_arm: {
          source: "../hammer_bot/assets/clown_Rarm.png"
        },
        l_arm: {
          source: "../hammer_bot/assets/clown_Larm.png"
        }
      };
      torso = new Image();
      torso.src = clowns.torso.source;
      head = new Image();
      head.src = clowns.head.source;
      r_arm = new Image();
      r_arm.src = clowns.r_arm.source;
      l_arm = new Image();
      l_arm.src = clowns.l_arm.source;
      torso.onload = function() {
        return ctx1.drawImage(torso, xpos, ypos);
      };
      head.onload = function() {
        return ctx1.drawImage(head, xpos - 12, ypos - 56);
      };
      r_arm.onload = function() {
        return ctx1.drawImage(r_arm, xpos + 81, ypos - 27);
      };
      l_arm.onload = function() {
        var angle;
        ctx1.drawImage(l_arm, xpos - 80, ypos - 4);
        angle = 0;
        return setInterval(function() {
          canvas1.width = canvas1.width;
          ctx1.drawImage(torso, xpos, ypos);
          angle += 20;
          rotateImage(head, xpos - 12, ypos - 56, head.width, head.height, angle);
          ctx1.drawImage(r_arm, xpos + 81, ypos - 27);
          return ctx1.drawImage(l_arm, xpos - 80, ypos - 4);
        }, 100);
      };
      return rotateImage = function(img, x, y, width, height, deg) {
        var rad;
        rad = (deg * Math.PI) / 180;
        ctx1.translate(x + width / 2, y + height / 2);
        ctx1.rotate(rad);
        ctx1.drawImage(img, width / 2 * (-1), height / 2 * (-1), width, height);
        ctx1.rotate(rad * (-1));
        return ctx1.translate((x + width / 2) * (-1), (y + height / 2) * (-1));
      };
    };
    return drawClown();
  });

}).call(this);
