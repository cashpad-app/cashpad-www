resizeHeader = -> $('#headline-container').height Math.max($( window ).height(), 812) * 0.8
angular
  .module 'geekywallet.landing', []
  .controller 'LandingCtrl', ($state, $scope) ->
    $scope.createDoc = ->
      $state.go 'editor', 
        docID: uniqueId(15)

    uniqueId = (length=8) ->
      id = ""
      id += Math.random().toString(36).substr(2) while id.length < length
      id.substr 0, length


    resizeHeader()
    $(window).resize resizeHeader
