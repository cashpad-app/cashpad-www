angular
  .module 'geekywallet.wallet', []
  .service '$wallet', ->
    gw = window.geekywallet
    (input) -> gw.parseAndCompute input
