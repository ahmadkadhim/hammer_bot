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
      var canvas, clown, clown_height, clown_width, ctx, sources, xpos, ypos;
      canvas = document.getElementById('canvas');
      ctx = canvas.getContext("2d");
      xpos = (canvas.width - 256) / 2;
      ypos = (canvas.height - 200) / 2;
      clown_width = 256;
      clown_height = 200;
      clown = new Image();
      clown.src = "../hammer_bot/assets/clown.png";
      sources = {
        torso: "../hammer_bot/assets/clown_torso.png",
        head: "../hammer_bot/assets/clown_head.png",
        r_arm: "../hammer_bot/assets/clown_R-arm.png",
        l_arm: "../hammer_bot/assets/clown_L-arm.png"
      };
      return clown.onload = function() {
        return ctx.drawImage(clown, xpos, ypos, clown_width, clown_height);
      };
    };
    return drawClown();
  });

}).call(this);
