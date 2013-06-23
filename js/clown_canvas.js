function printClown() {
  var stage = new Kinetic.Stage({
    container: 'container',
    width: 580,
    height: 340
  });
  var layer = new Kinetic.Layer();

  var blueRect = new Kinetic.Rect({
    x: 50,
    y: 75,
    width: 100,
    height: 50,
    fill: '#00D2FF',
    stroke: 'black',
    strokeWidth: 4
  });

  layer.add(blueRect);
  stage.add(layer);

  // one revolution per 4 seconds
  var angularSpeed = Math.PI / 2;
  var anim = new Kinetic.Animation(function(frame) {
    var angleDiff = frame.timeDiff * angularSpeed / 1000;
    blueRect.rotate(angleDiff);
  }, layer);

  anim.start();
};
printClown()


