// Generated by CoffeeScript 1.6.3
(function() {
  $(document).ready(function() {
    $(document).keydown(function(e) {
      var direction;
      direction = {};
      switch (e.keyCode) {
        case 37:
          direction = {
            strafe: -1
          };
          $("#left").css("background-color", "rgba(233,22,99,.8)");
          break;
        case 38:
          direction = {
            forward: 1
          };
          $("#up").css("background-color", "rgba(233,22,99,.8)");
          break;
        case 39:
          direction = {
            strafe: 1
          };
          $("#right").css("background-color", "rgba(233,22,99,.8)");
          break;
        case 40:
          direction = {
            forward: -1
          };
          $("#down").css("background-color", "rgba(233,22,99,.8)");
          break;
        case 65:
          direction = {
            turn: -1,
            forward: 1
          };
          break;
        case 68:
          direction = {
            turn: 1,
            forward: 1
          };
          break;
        case 32:
          direction = {};
          $("#stop").css("background-color", "rgba(233,22,99,.8)");
      }
      return $.ajax("http://192.168.0.105:8071/motion-control/update", {
        data: direction,
        dataType: "jsonp"
      });
    });
    return $(document).keyup(function(e) {
      return $(".arrow").css("background-color", "rgba(1,204,124,.6)");
    });
  });

}).call(this);
