# for animating the dance canvas on selection of dances

# appears source is //cdnjs.cloudflare.com/ajax/libs/kineticjs/4.3.1/kinetic.min.js

  canvas = document.getElementById('canvas');
  ctx = canvas.getContext("2d")

  # dimensions:   width:  580 height:   340

  ctx.beginPath()
  ctx.moveTo(100, 150)
  ctx.lineTo(300, 20)
  ctx.stroke()
