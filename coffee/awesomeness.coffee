$(document).ready ->

    console.log("hele")


    $(document)keydown e ->
        direction = {}
        console.log(e.keycode)
        if e.keycode == 37 #left
            direction = {forward: 1, turn: 1, strafe: 0}

        else if e.keycode == 38 #up
            direction = {forward: 1, turn: 0, strafe: 0}

        else if e.keycode == 39 #right
            direction = {forward: 1, turn: -1, strafe: 0}

        else if e.keycode == 40 #down
            direction = {forward: -1, turn: 0, strafe: 0}

        $.ajax("http://127.0.0.1:8071/motion-control/update", {
                data: direction,
                dataType: "jsonp",
                }
        )


# bindings =
#   forward: {a: +1, s: +1, d: +1, f: +1}
#   turn: {a: +1, s: -1, d: +1, f: -1}
#   strafe: {a: +1, s: -1, d: -1, f: +1}

# motionControlSettings = { forward: 0, turn: 0, strafe: 0 }
