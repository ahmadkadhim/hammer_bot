// Generated by CoffeeScript 1.6.3
(function() {
    $(document).ready(function() {
        return $(document).keydown(function(e) {
          console.log(e.keyCode);
            var direction;
            direction = {
              forward: 0,
                turn: 0,
                strafe: 0
            };
            switch(e.keyCode){

              case 37:  //left
                direction = {
                  forward: 1,
                  turn: -1
                 };
                 break;

              case 38: //up
                direction = {
                  forward: 1
                };
                break;

              case 39: //right
                direction = {
                  forward: 1,
                  turn: 1
                };
                break;

              case 40:  //down
                direction = {
                  forward: -1
                };
                break;

              case 65: //a
                direction = {
                  strafe: -1
                };
                break;

              case 68: //d
                direction = {
                  strafe: 1
                };
                break;
            }

            return $.ajax("http://127.0.0.1:8071/motion-control/update", {
              data: direction,
              dataType: "jsonp"
            });
        });
    });

}).call(this);
