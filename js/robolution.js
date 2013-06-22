// Generated by CoffeeScript 1.6.3
(function() {
  $(document).ready(function() {
    var AjaxRequest, Dance, PressKeys, keyMap, moonwalk, server;
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
    PressKeys = (function() {
      function PressKeys() {}

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

      return PressKeys;

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
    Dance = (function() {
      var moves;

      function Dance() {}

      moves = [37, 38, 39, 40];

      Dance.prototype.start = function(duration) {
        var start_time;
        start_time = Date.now();
        return setInterval(function() {
          var current_move, now_time;
          current_move = moves[Math.floor(Math.random() * moves.length)];
          now_time = Date.now();
          if (start_time + Date.now() >= (now_time * 2) + duration) {
            console.log("times up");
          }
          console.log("start time: " + start_time + ", now time: " + now_time);
          return server.get(keyMap[current_move].direction);
        }, 1000);
      };

      return Dance;

    })();
    moonwalk = new Dance;
    moonwalk.start();
    return server = new AjaxRequest;
  });

}).call(this);
