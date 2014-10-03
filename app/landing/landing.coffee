resizeHeader = -> $('#headline-container').height Math.max($( window ).height(), 812) * 0.8
angular
  .module 'geekywallet.landing', []
  .controller 'LandingCtrl', ->
    console.log $('#headline-container')
    resizeHeader()
    $(window).resize resizeHeader
