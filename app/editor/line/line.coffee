angular
  .module 'geekywallet.editor.line', []
  .controller 'LineCtrl', ($scope, $stateParams, $computedLines) ->
    $scope.line = $stateParams.lineIndex
    $scope.computedLines = $computedLines
