// Generated by CoffeeScript 1.6.3
(function() {
  $(document).ready(function() {
    console.log("hele");
    return $(document).keydown(function(e) {
      var direction;
      direction = {};
      console.log(e.keyCode);
      if (e.keyCode === 37) {
        direction = {
          forward: 1,
          turn: 1,
          strafe: 0
        };
      } else if (e.keyCode === 38) {
        direction = {
          forward: 1,
          turn: 0,
          strafe: 0
        };
      } else if (e.keyCode === 39) {
        direction = {
          forward: 1,
          turn: -1,
          strafe: 0
        };
      } else if (e.keyCode === 40) {
        direction = {
          forward: -1,
          turn: 0,
          strafe: 0
        };
      }
      return $.ajax("http://127.0.0.1:8071/motion-control/update", {
        data: direction,
        dataType: "jsonp"
      });
    });
  });

}).call(this);
