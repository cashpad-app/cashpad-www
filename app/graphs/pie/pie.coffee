angular.module 'geekywallet.pie', ['paths']
  .directive 'gwPie', ->
    scope: true
    restrict: 'AE'
    templateUrl: 'graphs/pie/view.html'
    replace: true
