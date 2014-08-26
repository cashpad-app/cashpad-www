angular
  .module 'geekywallet.wallet', []
  .service '$wallet', ->
    gw = window.geekywallet
    (input) -> gw.computeFromParsed gw.parser.parse input
