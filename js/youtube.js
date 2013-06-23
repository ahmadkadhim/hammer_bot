var player;
function onYouTubeIframeAPIReady() {
  player = new YT.Player('player', {
    height: '200',
    width: '500',
    playerVars:{'autoplay':1},
    videoId: 'HMWAKW303pg',
    events: {
      'onReady': onPlayerReady,
      'onStateChange': onPlayerStateChange
    }
  });
}

function onPlayerReady(event) {
  console.log("coo")
  event.target.playVideo();
}

var done = false;
function onPlayerStateChange(event) {
  if (event.data == YT.PlayerState.PLAYING && !done) {
    setTimeout(stopVideo, 6000);
    done = true;
  }
}
// function stopVideo() {
//   player.stopVideo();
// }

